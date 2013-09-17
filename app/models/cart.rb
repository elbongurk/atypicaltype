class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :orders

  def total
    Product.includes(:line_items).where(line_items: { cart_id: self.id }).sum("products.price * line_items.quantity")
  end
end
