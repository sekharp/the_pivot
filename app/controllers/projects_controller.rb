class ProjectsController < ApplicationController
  def index
    @projects = Project.where(status: "Active")
  end
end
