class Order < ActiveRecord::Base
  belongs_to :cart, counter_cache: true
  has_many :line_items, through: :cart
  has_one :user, through: :cart
end
