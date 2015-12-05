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

  def create_borrower
    User.create!(first_name: 'John',
                 last_name:  'Doe',
                 username:   'jdoe',
                 password:   'password')
  end

  def create_project
    Project.create!(goal_amount: 1000,
                    title:       "Buy me a goat",
                    description: "Mostly goat purchases",
                    image: "https://rudrakshagemstones.files.wordpress.com/2013/06/lord-ganesha.jpg"
                    )
  end

  def add_project_to_cart(project)
    visit new_user_cart_project_path(user: project.user.slug, project: project)
    within '.lend-form' do
      fill_in 'Amount', with: '200'
      click_button 'Lend!'
    end
  end
end
