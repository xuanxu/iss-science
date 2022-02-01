require "roo"

def data_file
  data_file_path = File.join(File.dirname(__FILE__, 2), "data", "experiments.xlsx")
  Roo::Spreadsheet.open(data_file_path)
end

namespace :iss do
  namespace :import do
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
        puts "Import failed: Expecting categories in the 6th column starting data at row 4"
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
        puts "Import failed: Expecting sponsoring space agencies in the 7th column starting data at row 4"
      end
    end
  end
end
