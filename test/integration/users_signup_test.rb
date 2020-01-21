require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: 'Example User', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar' } }
      follow_redirect!
      assert_template 'users/show'
      assert_not flash.empty?
    end
  end

  test 'invalid sign up information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: '', email: 'invalid@mail', password: 'foo', password_cofirmation: 'baz' } }
    end
    assert_template 'users/new'
  end
end
