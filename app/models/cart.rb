class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :orders

  def total
    # TODO: this doesn't handle quantity!
    Product.includes(:line_items).where(line_items: { cart_id: self.id }).sum(:price)
  end
end
