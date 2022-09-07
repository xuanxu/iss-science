class ApplicationController < ActionController::Base

  def admin_required
    http_basic_authenticate_or_request_with name: ENV['ISS_USER'].to_s, password: ENV['ISS_PASS'].to_s
  end
end
