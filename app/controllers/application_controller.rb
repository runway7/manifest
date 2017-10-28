# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  after_action :skip_cookies

  def skip_cookies
    request.session_options[:skip] = true
  end
end
