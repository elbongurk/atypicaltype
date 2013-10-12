class Feedback < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :message, presence: true
end
