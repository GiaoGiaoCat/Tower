module EventsHelper
  def show_extra_info_by_action(extra, action)
    case action
    when 'todo_assign_user', 'todo_change_user'
      User.find(extra).nickname if extra
    when 'todo_changed_expiry_on'
      if extra
        DateTime.parse(extra).strftime('%m-%d')
      else
        '没有截止日期'
      end
    end
  end
end
