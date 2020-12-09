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
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign Up'
  end
end
