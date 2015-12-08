ENV['RAILS_ENV'] ||= 'test'
  require 'simplecov'
  SimpleCov.start("rails")

  require File.expand_path('../../config/environment', __FILE__)
  require 'rails/test_help'
  require 'minitest/pride'
  require 'mocha/mini_test'
  require 'capybara/rails'

SimpleCov.start("rails")

class ActiveSupport::TestCase
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    reset_session!
  end

  def create_lender
    lender = User.create!(first_name: 'Matt',
                          last_name:  'Doe',
                          username:   'matt',
                          password:   'password')
    lender.roles << Role.find_by(name: "lender")
    lender
  end

  def create_borrower
    borrower = User.create!(first_name: 'John',
                            last_name:  'Doe',
                            username:   'jdoe',
                            password:   'password')
    borrower.roles << Role.find_by(name: 'borrower')
    borrower
  end

  def create_admin
    create_roles
    admin = User.create!(first_name: 'admin',
                         last_name:  'admin',
                         username:   'admin',
                         password:   'password')
    admin.roles << Role.find_by(name: "admin")
    admin
  end

  def login_admin
    visit login_path

    fill_in "Username", with: "admin"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  def login_lender
    visit login_path

    fill_in "Username", with: "matt"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  def create_project
    Project.create!(goal_amount: 1000,
                    title:       "Buy me a goat",
                    description: "Mostly goat purchases",
                    status:      "Active",
                    image:       "https://rudrakshagemstones.files.wordpress.com/2013/06/lord-ganesha.jpg"
                    )
  end

  def create_pending_project
    Project.create!(goal_amount: 22000,
                    title:       "Pending goat project",
                    description: "Eventually goat purchase, once this is approved",
                    status:      "Pending",
                    image:       "https://rudrakshagemstones.files.wordpress.com/2013/06/lord-ganesha.jpg"
                    )
  end

  def create_roles
    Role.create!(name: "lender")
    Role.create!(name: "borrower")
    Role.create!(name: "admin")
  end

  def create_roles_borrower_project_and_lender
    create_roles
    borrower = create_borrower
    borrower.projects << create_project
    create_lender
  end

  def add_project_to_cart(project)
    visit new_user_cart_project_path(user: project.user.slug, project: project)
    within '.lend-form' do
      fill_in 'Amount', with: '200'
      click_button 'Lend!'
    end
  end
end
