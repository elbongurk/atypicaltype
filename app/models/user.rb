# TODO: Would be nice to abstract the instagram stuff out of here
class User < ActiveRecord::Base
  after_create :onboard

  has_one :cart, -> { where orders_count: 0 }
  has_many :carts
  has_many :orders, through: :carts
  has_many :photos

  def onboard
    UserOnboardJob.new(self.id).perform
  end

  def cart
    super || Cart.create(user_id: self.id)
  end
end
