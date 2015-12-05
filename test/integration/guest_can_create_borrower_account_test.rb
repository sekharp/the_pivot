require 'test_helper'

class GuestCanCreateBorrowerAccountTest < ActionDispatch::IntegrationTest
  test 'guest can view choose account type page' do
    visit '/'
    within '#primary-navigation' do
      click_link 'Create Account'
    end

    assert_equal '/users/new', current_path
    assert page.has_content? 'Choose an Account Type'

    within '.account-types' do
      assert page.has_css? '.lender-btn', 'Create Lender Account'
      assert page.has_css? '.borrower-btn', 'Create Borrower Account'
    end
  end

  test 'guest can view create lender account form' do
    create_role('lender')
    visit '/users/new'
    click_button 'Create Lender Account'

    assert_equal '/lenders/new', current_path

    within '.new-lender-form' do
      assert page.has_content? 'Username'
      assert page.has_content? 'First name'
      assert page.has_content? 'Last name'
      assert page.has_content? 'Password'
      assert page.has_content? 'Street address'
      assert page.has_content? 'City'
      assert page.has_content? 'State'
      assert page.has_content? 'Zip'
      assert page.has_button? 'Create Account'
    end
  end

  test 'guest can view create borrower account form' do
    create_role('borrower')
    visit '/users/new'
    click_button 'Create Borrower Account'

    assert_equal '/borrowers/new', current_path

    within '.new-borrower-form' do
      assert page.has_content? 'Username'
      assert page.has_content? 'First name'
      assert page.has_content? 'Last name'
      assert page.has_content? 'Password'
      assert page.has_content? 'Street address'
      assert page.has_content? 'City'
      assert page.has_content? 'State'
      assert page.has_content? 'Zip'
      assert page.has_button? 'Create Account'
    end
  end

  test 'guest can create lender account' do
    create_role('lender')
    visit 'lenders/new'

    fill_in 'Username', with: 'cmejia'
    fill_in 'First name', with: 'Chaim'
    fill_in 'Last name', with: 'Mejia'
    fill_in 'Password', with: 'password'
    fill_in 'Street address', with: '123 example st.'
    fill_in 'City', with: 'Examplesburg'
    fill_in 'State', with: 'EX'
    fill_in 'Zip', with: '12345'

    click_button 'Create Account'

    new_user = User.find_by(username: 'cmejia')

    assert new_user.roles.map(&:name).include?('lender')
  end

  test 'guest can create borrower account' do
    create_role('borrower')
    visit 'borrowers/new'

    fill_in 'Username', with: 'cmejia'
    fill_in 'First name', with: 'Chaim'
    fill_in 'Last name', with: 'Mejia'
    fill_in 'Password', with: 'password'
    fill_in 'Street address', with: '123 example st.'
    fill_in 'City', with: 'Examplesburg'
    fill_in 'State', with: 'EX'
    fill_in 'Zip', with: '12345'

    click_button 'Create Account'

    new_user = User.find_by(username: 'cmejia')

    assert new_user.roles.map(&:name).include?('borrower')
  end

  def create_role(name)
    Role.create!(name: name)
  end
end
