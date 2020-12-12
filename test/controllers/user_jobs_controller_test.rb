require 'test_helper'

class UserJobsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_jobs_new_url
    assert_response :success
  end

  test "should get create" do
    get user_jobs_create_url
    assert_response :success
  end

  test "should get update" do
    get user_jobs_update_url
    assert_response :success
  end

end
