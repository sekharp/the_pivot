class UserAuthenticationTest < ActionDispatch::IntegrationTest
  test "visitor can see login link" do
    visit root_path

    within("#primary-navigation") do
      assert page.has_content?("Login")
    end
  end

  # test "visitor can create account and sign in" do
  #   visit root_path
  #
  #   click_link "Create Account"
  #   assert_equal "/users/new", current_path
  #
  #   fill_in "Username", with: "Matt"
  #   fill_in "First name", with: "Matt"
  #   fill_in "Last name", with: "Matt"
  #   fill_in "Password", with: "password"
  #   click_button "Create Account"
  #
  #   assert_equal '/dashboard', current_path
  #   within("#nav-bar") do
  #     assert page.has_content?("Logged in as Matt")
  #   end
  #   within("#profile") do
  #     assert page.has_content?("Profile")
  #     assert page.has_content?("Matt")
  #   end
  #   within("#primary-navigation") do
  #     refute page.has_content?("Login")
  #     assert page.has_content?("Logout")
  #   end
  # end

  test "lender can login" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end
  end

  test "logged in user sees cart contents" do
    create_roles_borrower_project_and_lender
    login_lender
    visit root_path

    click_button "Learn More"
    within(".lend-btn") do
    click_link "Lend"
    end
    fill_in "Amount", with: "50"
    click_button "Lend!"

    assert_equal cart_index_path, current_path

    within("#cart-contents") do
      assert page.has_content?("50")
    end
  end
end
