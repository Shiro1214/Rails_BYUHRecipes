require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
   test "users can sign up" do
     visit root_path
     
     click_on "Sign Up"
     fill_in "Name", with: "Test Signup"
     fill_in "Email", with: "signup@test.com"
     fill_in "Title", with: "Master Chef"
     fill_in "Role", with: "user"
     fill_in "Password", with: "secret"
     fill_in "Confirm Password", with: "secret"
     
     click_button "Sign Up"
     
     assert_equal page.current_path, root_path
     assert_text "You are successfully sign up."
     
     assert_text "Logout"
     assert_text "Test Signup"
     refute page.has_content?("Login")
   end
   
    test "user cannot sign up with errors" do
     visit signup_path
     
     fill_in "Name", with: "Test Signup"
     fill_in "Email", with: "signuptest.com" # no @ in email
     fill_in "Title", with: "Master Chef"
     fill_in "Role", with: "user"
     fill_in "Password", with: "secret"
     fill_in "Confirm Password", with: "secret"
     
     click_button "Sign Up"

     assert_text "Please fix the erros below."
   end
end
