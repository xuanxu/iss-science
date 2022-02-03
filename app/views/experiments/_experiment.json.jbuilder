json.extract! experiment, :id, :short_name, :full_name, :created_at, :updated_at
json.url experiment_url(experiment, format: :json)
