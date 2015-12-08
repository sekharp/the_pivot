require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  def create_lender
    User.create!(username:   "pwey",
                 password:   "password",
                 first_name: "pat",
                 last_name:  "wey")
  end

  def create_project
    Project.create!(title:       "my project",
                    description: "my description",
                    user_id:     1,
                    goal_amount: 200)
  end

  test "it belongs to a user" do
    lender = create_lender
    project = create_project
    loan = Loan.new(user_id: lender.id,
                    project_id: project.id,
                    amount: 100)

    assert_equal lender, loan.user
  end

  test "it belongs to a project" do
    lender = create_lender
    project = create_project
    loan = Loan.new(user_id: lender.id,
                    project_id: project.id,
                    amount: 100)

    assert_equal project, loan.project
  end

  test "it has an amount" do
    lender = create_lender
    project = create_project
    loan = Loan.new(user_id: lender.id,
                    project_id: project.id,
                    amount: 100)

    assert_equal 100, loan.amount
  end

  test "it is invalid without an amount" do
    lender = create_lender
    project = create_project
    loan = Loan.new(user_id: lender.id,
                    project_id: project.id)

    refute loan.valid?
  end

  test "completed returns completed loans" do
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "completed")

    assert_equal [loan], Loan.completed
  end

  test "pending returns pending loans" do
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "pending")

    assert_equal [loan], Loan.pending
  end

  test "cancelled returns cancelled loans" do
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "cancelled")

    assert_equal [loan], Loan.cancelled
  end

  test "active returns active loans" do
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "active")

    assert_equal [loan], Loan.active
  end




end
