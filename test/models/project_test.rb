require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def valid_project
    Project.new(title: 'my title',
                goal_amount: 200)
  end

  def create_user
    User.create!(username:   "pwey",
                 password:   "password",
                 first_name: "pat",
                 last_name:  "wey")
  end

  def create_category
    Category.create!(title: "my category")
  end

  test "it is valid" do
    assert valid_project.valid?
  end

  test "it has a title" do
    assert_equal "my title", valid_project.title
  end

  test "it is invalid without a title" do
    project = valid_project
    project.title = ""

    refute project.valid?
  end

  test "it has a goal amount" do
    assert_equal 200, valid_project.goal_amount
  end

  test "it is invalid without a goal amount" do
    project = valid_project
    project.goal_amount = nil

    refute project.valid?
  end

  test "it has a slug" do
    assert_equal "my-title", valid_project.set_slug
  end

  test "it belongs to a user" do
    user = create_user
    project = valid_project
    project.user_id = user.id

    assert_equal user, project.user
  end

  test "it belongs to a category" do
    category = create_category
    project = valid_project
    project.category_id = category.id

    assert_equal category, project.category
  end

  test "it responds to loans" do
    assert valid_project.respond_to? :loans
  end

  test "total_loans_amount returns 0 for unfunded project" do
    assert_equal 0, valid_project.total_loans_amount
  end

  test "total_loans_amount returns amount of loans for project" do
    project = valid_project
    project.loans << Loan.new(amount: 200)
    project.loans << Loan.new(amount: 100)

    assert_equal 300, project.total_loans_amount
  end

  test "percent_funded returns percentage of goal amount funded for project" do
    project = valid_project
    project.loans << Loan.new(amount: 100.0)

    assert_equal 50.00, project.percent_funded
  end

  test "completed returns completed loans" do
    skip
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "completed")

    assert_equal loan, Loan.completed
  end

  test "pending returns pending loans" do
    skip
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "pending")

    assert_equal [loan], Loan.pending
  end

  test "cancelled returns cancelled loans" do
    skip
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "cancelled")

    assert_equal [loan], Loan.cancelled
  end

  test "active returns active loans" do
    skip
    lender = create_lender
    project = create_project
    loan = Loan.create!(user_id: lender.id,
                        project_id: project.id,
                        amount: 100,
                        status: "active")

    assert_equal [loan], Loan.active
  end
end
