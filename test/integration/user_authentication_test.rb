class UserAuthenticationTest < ActionDispatch::IntegrationTest
  test "visitor can see login link" do
    visit root_path

    within("#primary-navigation") do
      assert page.has_content?("Login")
    end
  end

  test "visitor can create account and sign in" do
    visit root_path

    click_link "Create Account"

    within(".new_user") do
      fill_in "Username", with: "Matt"
      fill_in "First name", with: "Matt"
      fill_in "Last name", with: "Matt"
      fill_in "Password", with: "password"
      click_button "Create Account"
    end

    assert_equal '/dashboard', current_path
    within("#nav-bar") do
      assert page.has_content?("Logged in as Matt")
    end
    within("#profile") do
      assert page.has_content?("Profile")
      assert page.has_content?("Matt")
    end
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end
  end

  test "user can login" do
    User.create(username: "Matt",
                first_name: "Matt",
                last_name: "Matt",
                password: "password")

    visit root_path

    click_link "Login"
    fill_in "Username", with: "Matt"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal root_path, current_path
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end
  end

  test "logged in user sees cart contents" do
    skip
    borrower = create_borrower
    borrower.projects << create_project
    visit root_path

    click_button "Learn More"
    within(".lend-btn") do
    click_link "Lend"
    end
    fill_in "Amount", with: "50"
    click_button "Lend!"


    click_link "Login"
    fill_in "Username", with: "Matt"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Cart"

    within("#cart-contents") do
      assert page.has_content?("Node_js")
      assert page.has_content?(6)
    end

    click_link "Logout"

    within("#primary-navigation") do
      assert page.has_content?("Login")
      refute page.has_content?("Logout")
    end
  end
end
