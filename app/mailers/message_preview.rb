class MessagePreview < MailView
  def order_confirmed
    order = Order.where.not(transaction_id: nil).first
    OrderMailer.confirmed(order)
  end

  def order_shipped
    order = Order.where.not(transaction_id: nil).first
    OrderMailer.shipped(order)
  end
end
