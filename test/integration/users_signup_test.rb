require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  test 'valid signup information with account activation' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user:
                                  { name: 'Example User',
                                    email: 'user@example.com',
                                    password: 'foobar',
                                    password_confirmation: 'foobar'
                                } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.length
    user = assigns(:user)
    assert_not user.activated?
    # try login before validation
    log_in_as user
    assert_not is_logged_in?
    # invalid activtion token
    get edit_account_activation_path('invalid token', email: user.email)
    assert_not is_logged_in?
    # valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong email')
    assert_not is_logged_in?
    # valid activation credentials
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  test 'invalid sign up information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: '', email: 'invalid@mail', password: 'foo', password_cofirmation: 'baz' } }
    end
    assert_template 'users/new'
  end
end
