module ApplicationHelper
  def link_to_projects_page
    link_to 'Return to Projects', projects_path, class: "col s5 right waves-effect waves-light btn"
  end

  # def current_admin?
  #  current_user && current_user.admin?
  # end

end
