require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  def user
    @user ||= users(:one)
  end
  # test "the truth" do
  #   assert true
  # end
  test "create todo should be touch created event" do
    todo = Todo.create(content: 'a new todo', handler_id: user.id)
    assert_equal 1, Event.size
  end
end
