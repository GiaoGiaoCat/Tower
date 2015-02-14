require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, { 'team_id' => 1 }
    assert_response :success
    assert_not_nil assigns(:events)
  end
end
