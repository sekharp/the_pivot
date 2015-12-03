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

  def create_projects(num)
    i = 0
    projects = []
    num.times do
      i += 1
      projects << Project.create!(goal_amount: 1000,
                                  title:       "Project # #{i}",
                                  description: "Description #{i}")
    end
    projects
  end
end
