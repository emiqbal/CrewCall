require 'rails_helper'

RSpec.describe "LoginFlows", type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it 'should be able to Sign Up' do
    visit '/'
    click_on 'Sign Up'
    fill_in 'Username', with: 'User'
    fill_in 'Email', with: 'test@user.com'
    within(".user_password") do
      fill_in 'Password', with: '123456'
    end
    within(".user_password_confirmation") do
      fill_in 'Password confirmation', with: '123456'
    end
    within(".form-actions") do
      click_on 'Sign Up'
    end
  end

    it 'should be able to Login In' do
    visit '/'
    within(".navbar") do
    click_on 'Login'
    end
    fill_in 'Email', with: :user
    fill_in 'Password', with: :user
    within(".form-actions") do
      click_on 'Log in'
    end
  end
end
