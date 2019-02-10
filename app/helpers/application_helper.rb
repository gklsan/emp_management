module ApplicationHelper
  def current_users_company
    current_user.company
  rescue StandardError
    nil
  end
end
