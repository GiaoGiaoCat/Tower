module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :source

    after_create :touch_created_event
    before_destroy :touch_destroyed_event
    after_save :touch_finished_event
    after_save :touch_assign_user_event
    after_save :touch_change_user_event
    after_save :touch_changed_expiry_on_event
  end

  module ClassMethods
  end

  private

  def touch_created_event
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def touch_destroyed_event
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def touch_finished_event
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def touch_changed_expiry_on_event
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def touch_assign_user_event
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def touch_change_user_event
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def touch_event(user_id, action, **options)
    event_parameters = default_parameters(user_id, action).merge(options)
    events.create(event_parameters)
  end

  def default_parameters(user_id, action)
    { user_id: user_id, action: action }
  end
end
