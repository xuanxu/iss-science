class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['ISS_USER'].to_s, password: ENV['ISS_PASS'].to_s
end
