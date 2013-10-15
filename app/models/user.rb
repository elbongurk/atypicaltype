# TODO: Would be nice to abstract the instagram stuff out of here
class User < ActiveRecord::Base
  after_create :onboard

  has_many :carts
  has_many :orders, through: :carts
  has_many :photos

  has_one :cart, -> { where "NOT EXISTS (SELECT 1 FROM orders WHERE orders.cart_id = carts.id AND orders.transaction_id IS NOT NULL)" }

  def cart
    super || Cart.create!(user_id: self.id)
  end

  private

  def onboard
    Delayed::Job.enqueue UserOnboardJob.new(self.id, 'desc')
  end
end
