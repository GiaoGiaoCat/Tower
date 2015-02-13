require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def todo
    todo = todos(:one)
  end

  def user
    @user ||= users(:one)
  end

  def member
    @member ||= users(:two)
  end

  def event
    Event.last
  end

  test 'create should be touch created event' do
    comment = todo.comments.create(content: 'this is a comment', handler_id: user.id, user_id: member.id)

    assert_equal 'reply_todo', event.action
    assert_equal user.id, event.user_id
  end
end
