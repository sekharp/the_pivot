class HomeController < ApplicationController
  def home
    @top_projects = Project.where(status: "Active").limit(3)
  end
end
