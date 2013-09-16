class Order < ActiveRecord::Base
  has_many :fulfillments
  belongs_to :cart
  has_one :user, through: :cart
  has_many :line_items, through: :cart

  def number
    self.id ? self.id + 60 : nil
  end

  def country
    "US"
  end

  def total
    sprintf('%.2f', subtotal + shipping + tax)
  end

  def subtotal    
    cart ? cart.total : 0.00
  end

  def shipping
    0.00
  end

  def tax
    tax_rate * (subtotal + shipping)
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
