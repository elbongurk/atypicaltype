class Order < ActiveRecord::Base
  has_many :fulfillments
  belongs_to :cart
  has_one :user, through: :cart
  has_many :line_items, through: :cart

  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true

  def number
    self.id + 60 if self.id
  end

  def country
    "US"
  end

  def total
    super || sprintf('%.2f', subtotal + shipping + tax)
  end

  def shipping
    super || 0.00
  end

  def tax
    super || (tax_rate * (subtotal + shipping))
  end

  def subtotal    
    cart ? cart.total : 0.00
  end

  def tax_rate
    # TODO: this is going to have to be better than this
    if state == "WI"
      0.055
    else
      0.000
    end    
  end

  def complete(transaction_id)
    update!(transaction_id: transaction_id, total: total, shipping: shipping, tax: tax)
    Delayed::Job.enqueue OrderFulfillmentJob.new(self.id)
  end
end
