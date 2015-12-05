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
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "projects" && action == "index"
    return true if controller == "users" && action.in?(%w(index show))
    return true if controller == "loans" && action.in?(%w(index show))
    return true if controller == "home" && action == "home"
  end

  def borrower_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "projects" && action == "index"
    return true if controller == "loans" && action.in?(%w(index show))
    return true if controller == "home" && action == "home"
  end

  def lender_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "projects" && action == "index"
    return true if controller == "loans" && action == "index"
    return true if controller == "home" && action == "home"
  end

  def guest_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "users/cart_projects" && action.in?(%w(new create))
    return true if controller == "cart" && action == "index"
    return true if controller == "projects" && action == "index"
    return true if controller == "home" && action == "home"
  end

end
