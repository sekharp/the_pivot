class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def finished?
    if status.include?("completed") || status.include?("cancelled")
      true
    end
  end
end
