require "yaml"
require "json"
require "faraday"

namespace :iss do
  namespace :prepare do

    desc "Extract experiments ids from NASA results page"
    task :ids,  [:suffix] => :environment do |t, args|

      suffix = args.suffix.blank? ? "" : "-#{args.suffix}"
      results_file_path = File.join(File.dirname(__FILE__, 2), "data", "results", "results#{suffix}.html")
      results_ids_file_path = File.join(File.dirname(__FILE__, 2), "data", "results", "ids#{suffix}.yml")

      if File.exist? results_file_path
        puts "Results file found: #{results_file_path}"
        results_html_path = File.read(results_file_path)
        ids = results_html_path.scan(/id="found_(\d+)"/)

        results_ids = ids.flatten.map { |id| id.to_i }.sort
        puts "#{results_ids.size} experiments detected"

        File.open(results_ids_file_path,'w') {|f| f.write results_ids.to_yaml}
        puts "Experiments ids saved to #{results_ids_file_path}"
      else
        puts "!! Results file not found: #{results_file_path}"
      end
    end

    desc "Save json data from NASA API for all listed experiment ids"
    task :download,  [:suffix] => :environment do |t, args|

      api_experiment_base_url = "https://api-g.iss.nasa.gov/PST4-API-PUBLIC/Investigation/"
      suffix = args.suffix.blank? ? "" : "-#{args.suffix}"
      ids_file_path = File.join(File.dirname(__FILE__, 2), "data", "results", "ids#{suffix}.yml")

      if File.exist? ids_file_path
        ids = YAML.load_file ids_file_path
        puts "Processing #{ids.size} experiment ids"

        ids.each do |id|
          experiment_url = api_experiment_base_url + id.to_s
          experiment_json_path = File.join(File.dirname(__FILE__, 2), "data", "experiments", "experiment-#{id}.json")

          unless File.exist?(experiment_json_path)
            response = Faraday.get(experiment_url)
            if response.status.between?(200, 299)
              puts "  ✅ Info for experiment #{id} downloaded!!"
              #experiment_data = JSON.parse(response.body)
              File.open(experiment_json_path,'w') {|f| f.write response.body}
            else
              puts "  ⚠️ Error retrieving info for experiment #{id}"
            end
          end

        end

        puts "Done! #{ids.size} json files ready in the data/experiments folder"
      else
        puts "  ❌ Ids file not found: #{ids_file_path}"
      end
    end

    desc "Load data into the database from the experiments json files"
    task load_data: :environment do
      experiment_files_list = Dir[File.join(File.dirname(__FILE__, 2), "data", "experiments") + "/*.json"]
      puts "📄 Reading data for #{experiment_files_list.size} experiments..."

      experiment_files_list.each do |experiment_file|

        experiment_data = JSON.load_file experiment_file

        id = experiment_data.dig("Investigation", "ID").to_i

        unless id > 0
          puts "  ⚠️ Error with file #{experiment_file}"
          next
        end

        if Experiment.exists?(external_id: id)
          puts "  ⏭ Experiment #{id} already exists in the DB"
          next
        end

        category_name = experiment_data.dig("Investigation", "CategoryName") || "Uncategorized"
        subcategory_name = experiment_data.dig("Investigation", "SubCategoryName") || "Unsubcategorized"
        space_agency_name = experiment_data.dig("Investigation", "SponsoringAgency")
        organization_name = experiment_data.dig("Investigation", "SupportingOrg")

        category = Category.find_or_create_by(name: category_name) if category_name
        subcategory = Subcategory.find_or_create_by(name: subcategory_name) if subcategory_name
        space_agency = SpaceAgency.find_or_create_by(name: space_agency_name) if space_agency_name
        organization = Organization.find_or_create_by(name: organization_name) if organization_name

        experiment = Experiment.new(external_id: id)
        experiment.name = experiment_data.dig("Investigation", "Name")
        experiment.title = experiment_data.dig("Investigation", "Title")
        experiment.pao_summary = experiment_data.dig("Investigation", "PAOSummary")
        experiment.research_summary = experiment_data.dig("Investigation", "ResearchSummary")
        experiment.research_description = experiment_data.dig("Investigation", "ResearchDescription")
        experiment.research_operations = experiment_data.dig("Investigation", "BriefResearchOperations")
        experiment.applications_in_space = experiment_data.dig("Investigation", "ApplicationsInSpace")
        experiment.applications_on_earth = experiment_data.dig("Investigation", "ApplicationsOnEarth")
        experiment.results = experiment_data.dig("Investigation", "Results")
        experiment.results_summary = experiment_data.dig("Investigation", "ResultsSummary")
        experiment.res_ops_reqs_protos = experiment_data.dig("Investigation", "Res_Ops_Reqs_Protos")
        experiment.hardware_payload = experiment_data.dig("HardwarePayload")
        experiment.nanoracks = experiment_data.dig("Nanoracks")
        experiment.dock_date = experiment_data.dig("Investigation", "DockDate")
        experiment.undock_date = experiment_data.dig("Investigation", "UnDockDate")
        experiment.results_publications_count = experiment_data["ResultsPublications"].size
        experiment.link_text = experiment_data.dig("Websites", 0, "Name")
        experiment.link_url = experiment_data.dig("Websites", 0, "Address")

        experiment.category = Category.find_or_create_by(name: category_name) if category_name
        experiment.subcategory = Subcategory.find_or_create_by(name: subcategory_name) if subcategory_name
        experiment.space_agency = SpaceAgency.find_or_create_by(name: space_agency_name) if space_agency_name
        experiment.organization = Organization.find_or_create_by(name: organization_name) if organization_name

        experiment.save!

        expeditions = experiment_data.dig("Investigation", "Increments").to_s.gsub("\n", "").split(",").map(&:strip)
        expeditions.each do |expedition_name|
          Expedition.find_or_create_by(name: expedition_name)
        end
        experiment.expeditions = Expedition.where(name: expeditions) unless expeditions.empty?

        developers = experiment_data["Developers"]
        developers.each do |dev_data|
          Developer.find_or_create_by(external_id: dev_data["ID"]) do |dev|
            dev.name = dev_data["Name"]
          end
        end
        experiment.developers = Developer.where(external_id: developers.map{|d| d["ID"]}) unless developers.empty?

        investigators = experiment_data["Investigators"]
        investigators.each do |investigator_data|
          Investigator.find_or_create_by(external_id: investigator_data["ID"]) do |investigator|
            investigator.name = investigator_data["Name"]
          end
        end
        experiment.investigators = Investigator.where(external_id: investigators.map{|i| i["ID"]}) unless investigators.empty?

        puts "  ✅ Experiment #{id} loaded!!"
      end
      puts "🏁 Done!"
    end

  end
end