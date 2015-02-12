require 'test_helper'

class TodoTest < ActiveSupport::TestCase
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

  test 'finished shoulde be make finished to true' do
    todo.finished!

    assert todo.finished
  end

  test 'assign user' do
    todo.assign_to(member.id)

    assert_equal  member.id, todo.user_id
  end

  test 'create should be touch created event' do
    todo = Todo.create(content: 'a new todo', handler_id: user.id)

    assert_equal 'todo_created', event.action
    assert_equal user.id, event.user_id
  end

  test 'destroy shoudle be touch destroyed event' do
    todo.handler_id = user.id
    todo.destroy

    assert_equal 'todo_destroyed', event.action
    assert_equal user.id, event.user_id
  end

  test 'finish shoudle be touch finished event' do
    todo.handler_id = user.id
    todo.finished!

    assert_equal 'todo_finished', event.action
    assert_equal user.id, event.user_id
  end

  test 'assign user from nil to member shoudle be touch assign user event' do
    todo.handler_id = user.id
    todo.assign_to(member.id)

    assert_equal 'todo_assign_user', event.action
    assert_equal user.id, event.user_id
    assert_equal nil, event.extra_1
    assert_equal member.id.to_s, event.extra_2
  end

  test 'change assgin user from user to member shoudle be touch change user event' do
    todo = todos(:two)
    todo.handler_id = user.id
    todo.assign_to(member.id)

    assert_equal 'todo_change_user', event.action
    assert_equal user.id, event.user_id
    assert_equal user.id.to_s, event.extra_1
    assert_equal member.id.to_s, event.extra_2
  end
end
