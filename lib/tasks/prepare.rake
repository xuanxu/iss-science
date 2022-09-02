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
              #experiment_data = JSON.parse(response.body)
              File.open(experiment_json_path,'w') {|f| f.write response.body}
            else
              puts "!! Error retrieving info for experiment #{id}"
            end
          end

        end

        puts "Done! #{ids.size} json files ready in the data/experiments folder"
      else
        puts "!! Ids file not found: #{ids_file_path}"
      end
    end

  end
end