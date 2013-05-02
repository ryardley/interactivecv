require 'test_helper'

class Api::V1::JobsControllerTest < ActionController::TestCase
  test "should get index" do
      get :index, format: :json
      assert_response :success
    end

    test "should get show" do
      get :show, id: Job.first.id, format: :json
      assert_response :success
    end
end
