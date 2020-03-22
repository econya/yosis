module UserRoleHelper
  def user_admin?
    user_signed_in? && current_user.role == 'admin'
  end
end
