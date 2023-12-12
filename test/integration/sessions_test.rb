require "test_helper"

class SessionsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "users can login" do
    FactoryBot.create :user, email: "testlogin@test.com", password: "secret"
    
    visit root_path
    click_on "Login"
    
    fill_in "Email", with: "testlogin@test.com"
    fill_in "Password", with: "secret"
    click_button "Login"
    
    assert_equal page.current_path, root_path
    assert_text "Logged In"
    assert_text "Logout"
    refute page.has_content?("Login")
  end
  test "users can't login with wrong password" do
    FactoryBot.create :user, email: "testlogin@test.com", password: "secret"
    
    visit login_path
    
    fill_in "Email", with: "testlogin@test.com"
    fill_in "Password", with: "wrong"
    click_button "Login"
    
    assert_equal page.current_path, login_path
    assert_text "Invalid Email or Password"
    refute page.has_content?("Logout")
  end
  test "users can logout" do
    login_user name: "George"
    
    visit root_path
    assert_text "George"
    
    click_on "Logout"
    
    assert_text "Logged out"
    refute page.has_content?("Logout")
    assert true
  end
end
