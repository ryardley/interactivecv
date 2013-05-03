require 'test_helper'

class SkillsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index, format: :json
      assert_response :success
    end

    test "should get show" do
      get :show, id: Skill.first.id, format: :json
      assert_response :success
    end
end
