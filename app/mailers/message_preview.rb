class MessagePreview < MailView
  def order_confirmed
    order = Order.find(1)
    OrderMailer.confirmed(order)
  end

  def order_shipped
    order = Order.find(1)
    OrderMailer.shipped(order)
  end
end
