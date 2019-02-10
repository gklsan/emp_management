class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_users_company
    current_user.company
  rescue StandardError
    nil
  end
end
