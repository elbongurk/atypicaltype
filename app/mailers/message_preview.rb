class MessagePreview < MailView
  def order_confirmed
    order = Order.where.not(transaction_id: nil).first
    OrderMailer.confirmed(order)
  end

  def order_shipped
    order = Order.where.not(transaction_id: nil).first
    unless order.fulfillments.present?
      order.fulfillments << Fulfillment.new(tracking_code: "13324324234234234", shipped_on: Date.today)
    end
    OrderMailer.shipped(order)
  end
end
