class Todo < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # relationships .............................................................
  belongs_to :todo_list
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :events, as: :source
  # validations ...............................................................
  validates :content, presence: true, length: { maximum: 1000 }
  # callbacks .................................................................
  after_create :touch_created_event
  before_destroy :touch_destroyed_event
  after_save :touch_finished_event
  after_save :touch_assign_user_event
  after_save :touch_change_user_event
  after_save :touch_changed_expiry_on_event
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  attr_accessor :handler_id
  # class methods .............................................................
  # public instance methods ...................................................
  def title
    content
  end

  def finished!
    update_attribute(:finished, true)
  end

  def assign_to(user_id)
    update_attribute(:user_id, user_id)
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  # private
  private

  def touch_created_event
    touch_event(handler_id, :todo_created)
  end

  def touch_destroyed_event
    touch_event(handler_id, :todo_destroyed)
  end

  def touch_finished_event
    touch_event(handler_id, :todo_finished) if finished_changed?
  end

  def touch_changed_expiry_on_event
    if expiry_on_changed?
      touch_event(handler_id, :todo_changed_expiry_on, { extra_1: expiry_on_was, extra_2: expiry_on })
    end
  end

  def touch_assign_user_event
    if user_id_changed? && user_id_was.blank?
      touch_event(handler_id, :todo_assign_user, { extra_1: user_id_was, extra_2: user_id })
    end
  end

  def touch_change_user_event
    if user_id_changed? && user_id_was.present?
      touch_event(handler_id, :todo_change_user, { extra_1: user_id_was, extra_2: user_id })
    end
  end

  def touch_event(user_id, action, **options)
    event_parameters = default_parameters(user_id, action).merge(options)
    events.create(event_parameters)
  end

  def default_parameters(user_id, action)
    { user_id: user_id, action: action }
  end
end
