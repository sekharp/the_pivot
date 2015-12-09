class HomeController < ApplicationController
  def home
    @top_projects = top_projects
  end

  private

  def top_projects
    binding.pry
    active = Project.where(status: "Active")
    active.map { |pro| proj, proj.total_loans_amount }
  end
end
