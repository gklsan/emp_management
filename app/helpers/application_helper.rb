module ApplicationHelper
  def current_users_company
    current_user.company rescue nil
  end
end
