require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def valid_category
    Category.new(title: "category")
  end

  test "it is valid" do
    assert valid_category.valid?
  end

  test "it is invalid without a title" do
    category = valid_category
    category.title = nil

    refute category.valid?
  end
end
