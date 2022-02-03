require "roo"

def data_file
  data_file_path = File.join(File.dirname(__FILE__, 2), "data", "experiments.xlsx")
  @data_spreadsheet ||= Roo::Spreadsheet.open(data_file_path)
end

namespace :iss do
  namespace :import do

    desc "Import principal investigators from the ISS xlsx file"
    task pi: :environment do
      pis = data_file.column(3)
      if pis[3].downcase == "principal investigator(s)"
        pis.shift(4)
        pis = pis.uniq.compact
        all_pis = []
        pis.each do |pi|
          pi_list = pi.split(";").map(&:strip)
          all_pis << pi_list
        end

        all_pis = all_pis.flatten.uniq.compact

        PrincipalInvestigator.find_or_create_by(name: "No P.I.")
        all_pis.each do |pi|
          PrincipalInvestigator.find_or_create_by(name: pi)
        end

        puts "#{all_pis.size} principal investigators imported!"
      else
        puts "Import failed: Expecting principal investigator(s) header in the 3rd column, 3rd row"
      end
    end

    desc "Import developers from the ISS xlsx file"
    task developers: :environment do
      devs = data_file.column(4)
      if devs[3].downcase == "developer(s)"
        devs.shift(4)
        devs = devs.uniq.compact
        all_devs = []
        devs.each do |dev|
          dev_list = dev.split(";").map(&:strip)
          all_devs << dev_list
        end

        all_devs = all_devs.flatten.uniq.compact

        Developer.find_or_create_by(name: "No developers")
        all_devs.each do |dev|
          Developer.find_or_create_by(name: dev)
        end

        puts "#{all_devs.size} developers imported!"
      else
        puts "Import failed: Expecting developer(s) header in the 4th column, 3rd row"
      end
    end

    desc "Import expeditions from the ISS xlsx file"
    task expeditions: :environment do
      expeditions = data_file.column(5)
      if expeditions[3].downcase == "expedition(s)"
        expeditions.shift(4)
        expeditions = expeditions.uniq.compact
        all_expeditions = []
        expeditions.each do |exp|
          expeditions_list = exp.split(";").map(&:strip)
          all_expeditions << expeditions_list
        end

        all_expeditions = all_expeditions.flatten.uniq.compact

        Expedition.find_or_create_by(name: "No expeditions")
        all_expeditions.each do |exp|
          Expedition.find_or_create_by(name: exp)
        end

        puts "#{all_expeditions.size} expeditions imported!"
      else
        puts "Import failed: Expecting expedition(s) header in the 5th column, 3rd row"
      end
    end

    desc "Import categories from the ISS xlsx file"
    task categories: :environment do
      categories = data_file.column(6)
      if categories[3].downcase == "category"
        categories.shift(4)
        categories = categories.uniq.compact

        Category.find_or_create_by(name: "No category")
        categories.each do |category|
          Category.find_or_create_by(name: category)
        end

        puts "#{categories.size} categories imported!"
      else
        puts "Import failed: Expecting categories header in the 6th column, 3rd row"
      end
    end

    desc "Import space agencies from the ISS xlsx file"
    task space_agencies: :environment do
      space_agencies = data_file.column(7)
      if space_agencies[3].downcase == "sponsoring space agency"
        space_agencies.shift(4)
        space_agencies = space_agencies.uniq.compact

        SpaceAgency.find_or_create_by(name: "No space agency")
        space_agencies.each do |space_agency|
          SpaceAgency.find_or_create_by(name: space_agency)
        end

        puts "#{space_agencies.size} space_agencies imported!"
      else
        puts "Import failed: Expecting sponsoring space agencies header in the 7th column, 3rd row"
      end
    end

    desc "Import data from the ISS xlsx file"
    task data: [:environment, :pi, :developers, :expeditions, :categories, :space_agencies] do
      data = data_file
      experiment_initial_count = Experiment.count
      5.upto(data.last_row) do |row|
        data_row = data_file.row(row)
        short_name = data_row[0]
        full_name = data_row[1]
        principal_investigators_raw = data_row[2].to_s
        developers_raw = data_row[3].to_s
        expeditions_raw = data_row[4].to_s
        category = Category.find_by(name: data_row[5].to_s.strip)
        space_agency = SpaceAgency.find_by(name: data_row[6].to_s.strip)

        no_category = Category.find_or_create_by(name: "No category")
        no_space_agency = SpaceAgency.find_or_create_by(name: "No space agency")

        exp = Experiment.find_or_create_by(short_name: short_name) do |e|
                                e.full_name = full_name
                                e.principal_investigators_raw = principal_investigators_raw
                                e.developers_raw = developers_raw
                                e.expeditions_raw = expeditions_raw
                                e.category = category || no_category
                                e.space_agency = space_agency || no_space_agency
        end

        exp.principal_investigators = PrincipalInvestigator.where(name: principal_investigators_raw.split(";").map(&:strip))
        exp.developers = Developer.where(name: developers_raw.split(";").map(&:strip))
        exp.expeditions = Expedition.where(name: expeditions_raw.split(";").map(&:strip))
        exp.save!
      end
      experiment_final_count = Experiment.count
      puts "#{experiment_final_count - experiment_initial_count} experiments added to the database"
    end
  end

  desc "Delete all experiments information in the database"
    task clean_slate: :environment do
      puts "Deleting experiments info..."
      Experiment.destroy_all

      puts "Deleting P.I. info..."
      PrincipalInvestigator.destroy_all

      puts "Deleting developers info..."
      Developer.destroy_all

      puts "Deleting expeditions info..."
      Expedition.destroy_all

      puts "Deleting categories info..."
      Category.destroy_all

      puts "Deleting space agencies info..."
      SpaceAgency.destroy_all

      puts "Done!"
    end
end
