class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :amount, presence: true

  scope :completed, -> { where(status: "Completed") }
  scope :pending, -> { where(status: "Pending") }
  scope :cancelled, -> { where(status: "Cancelled") }
  scope :active, -> { where(status: "Active") }

  def finished?
    if status.include?("completed") || status.include?("cancelled")
      true
    end
  end
end
