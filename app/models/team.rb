class Team < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # relationships .............................................................
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :projects, dependent: :destroy, inverse_of: :team
  has_many :events, through: :projects, dependent: :destroy
  # validations ...............................................................
  validates :name, presence: true
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  # private
end
