class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    if user.admin?
      admin_permissions
    elsif user.borrower? && user.lender?
      combined_user_permissions
    elsif user.borrower?
      borrower_permissions
    elsif user.lender?
      lender_permissions
    else
      guest_permissions
    end
  end

  private

  def admin_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(index show update edit))
    return true if controller == "loans" && action.in?(%w(index show))
    return true if controller == "home" && action == "home"
    return true if controller == "admin/dashboard" && action.in?(%w(index show))
    return true if controller == "admin/projects" && action.in?(%w(update))
    return true if controller == "categories" && action.in?(%w(index show))
  end

  def combined_user_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users" && action.in?(%w(edit update combined_dashboard borrower_dashboard lender_dashboard))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "projects" && action == "index"
    return true if controller == "loans" && action.in?(%w(index show))
    return true if controller == "home" && action == "home"
    return true if controller == "cart" && action == "index"
    return true if controller == "categories" && action.in?(%w(index show))
  end

  def borrower_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users" && action.in?(%w(edit update borrower_dashboard))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "projects" && action == "index"
    return true if controller == "loans" && action.in?(%w(index show))
    return true if controller == "home" && action == "home"
    return true if controller == "categories" && action.in?(%w(index show))
    return true if controller == "borrowers/projects" && action.in?(%w(new create))
  end

  def lender_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users" && action.in?(%w(edit update lender_dashboard))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "users/cart_projects" && action.in?(%w(new create))
    return true if controller == "projects" && action == "index"
    return true if controller == "loans" && action.in?(%w(index create))
    return true if controller == "home" && action == "home"
    return true if controller == "cart" && action == "index"
    return true if controller == "categories" && action.in?(%w(index show))
  end

  def guest_permissions
    return true if controller == "session" && action.in?(%w(new create destroy))
    return true if controller == "users/projects" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(new create))
    return true if controller == "lenders" && action == "new"
    return true if controller == "borrowers" && action == "new"
    return true if controller == "users/cart_projects" && action.in?(%w(new create))
    return true if controller == "cart" && action == "index"
    return true if controller == "loans" && action == "create"
    return true if controller == "projects" && action == "index"
    return true if controller == "home" && action == "home"
    return true if controller == "users" && action.in?(%w(new create show))
    return true if controller == "categories" && action.in?(%w(index show))
  end

end
