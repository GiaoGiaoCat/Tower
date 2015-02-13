class Comment < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # relationships .............................................................
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :events, as: :source
  # validations ...............................................................
  validates :content, presence: true
  # callbacks .................................................................
  after_create :touch_created_event
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

  def touch_event(user_id, action, **options)
    event_parameters = default_parameters(user_id, action).merge(options)
    events.create(event_parameters)
  end

  def default_parameters(user_id, action)
    { user_id: user_id, action: action }
  end
end
