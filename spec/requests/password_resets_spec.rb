require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:roberto)
  end
  
  describe "GET /password_resets" do
    it "works! (now write some real specs)" do
      get new_password_reset_path
         assert_template 'password_resets/new'
         # Invalid email
         post password_resets_path, params: { password_reset: { email: "" } }
         assert_not flash.empty?
         assert_template 'password_resets/new'
         # Valid email
         post password_resets_path,
              params: { password_reset: { email: @user.email } }
         assert_not_equal @user.reset_digest, @user.reload.reset_digest
         assert_equal 1, ActionMailer::Base.deliveries.size
         assert_not flash.empty?
         assert_redirected_to root_url
         # Password reset form
         user = assigns(:user)
         # Wrong email
         get edit_password_reset_path(user.reset_token, email: "")
         assert_redirected_to root_url
         # Inactive user
         user.toggle!(:activated)
         get edit_password_reset_path(user.reset_token, email: user.email)
         assert_redirected_to root_url
         user.toggle!(:activated)
         # Right email, wrong token
         get edit_password_reset_path('wrong token', email: user.email)
         assert_redirected_to root_url
         # Right email, right token
         get edit_password_reset_path(user.reset_token, email: user.email)
         assert_template 'password_resets/edit'
         assert_select "input[name=email][type=hidden][value=?]", user.email
         # Invalid password & confirmation
         patch password_reset_path(user.reset_token),
               params: { email: user.email,
                         user: { password:              "foobaz",
                                 password_confirmation: "barquux" } }
         assert_select 'div#error_explanation'
         # Empty password
         patch password_reset_path(user.reset_token),
               params: { email: user.email,
                         user: { password:              "",
                                 password_confirmation: "" } }
         assert_select 'div#error_explanation'
         # Valid password & confirmation
         patch password_reset_path(user.reset_token),
               params: { email: user.email,
                         user: { password:              "foobaz",
                                 password_confirmation: "foobaz" } }
         assert is_logged_in?
         assert_not flash.empty?
         assert_redirected_to user
       end
     end
end
# RSpec.describe "PasswordResets", type: :request do
#   describe "GET /password_resets" do
#     it "works! (now write some real specs)" do
#       get password_resets_index_path
#       expect(response).to have_http_status(200)
#     end
#   end
# end
