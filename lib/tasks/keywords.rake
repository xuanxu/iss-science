require "yaml"
require "json"
require "faraday"

namespace :iss do
  namespace :keywords do

    desc "Search unrevised experiments texts for keywords and tag them"
    task process: :environment do
      fields_to_search_in = ["pao_summary",
                             "research_summary",
                             "research_description",
                             "research_operations",
                             "applications_in_space",
                             "applications_on_earth",
                             "results",
                             "results_summary",
                             "res_ops_reqs_protos",
                             "hardware_payload",
                             "nanoracks"]

      Keyword.all.each do |keyword|
        sql_string_pieces = []
        fields_to_search_in.each do |field|
          field_pieces = []
          keyword.variations_list.each do |variation|
            field_pieces << "#{field} ILIKE '%#{variation}%'"
          end
          sql_string_pieces << field_pieces.join(" OR ")
        end
        sql_string = sql_string_pieces.join(" OR ")

        Experiment.unrevised.where(sql_string).find_in_batches do |group|
          group.each { |experiment| experiment.keywords << keyword unless experiment.keywords.include?(keyword)}
        end

      end
    end

    desc "Show number of experiments per keyword"
    task stats: :environment do
      Keyword.all.each do |keyword|
        puts "Experiments tagged as #{ keyword.name }: #{ keyword.experiments.count }"
      end
    end

    desc "Remove all keywords from every experiment"
    task remove: :environment do
      Keyword.all.each do |keyword|
        keyword.experiments = []
      end
    end

  end
end