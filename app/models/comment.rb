class Comment < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  include Eventable
  # relationships .............................................................
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  # validations ...............................................................
  validates :content, presence: true
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  attr_accessor :handler_id
  # class methods .............................................................
  # public instance methods ...................................................
  def title
    content
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def touch_created_event
    action = "reply_#{commentable_type.downcase}".to_sym
    touch_event(handler_id, action, { extra_1: commentable_id })
  end

  def touch_destroyed_event; end

  def touch_finished_event; end

  def touch_changed_expiry_on_event; end

  def touch_assign_user_event; end

  def touch_change_user_event; end
end
