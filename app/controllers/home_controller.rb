class HomeController < ApplicationController
  def home
    @top_projects = Project.limit(3)
  end
end
