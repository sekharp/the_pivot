class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    if user.platform_admin?
      platform_admin_permissions
    elsif user.borrower?
      borrower_permissions
    elsif user.lender?
      lender_permissions
    else
      guest_permissions
    end
  end

  private

  def platform_admin_permissions
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(index show))
    return true if controller == "loans" && action.in?(%w(index show))
  end

  def borrower_permissions
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "loans" && action.in?(%w(index show))
  end

  def lender_permissions
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "loans" && action == "index"
  end

  def guest_permissions
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "projects" && action == "index"
  end

end
