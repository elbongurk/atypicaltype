class OrderConfirmationJob < Struct.new(:order_id)
  def perform
    order = Order.find(order_id)
    
    OrderMailer.confirmed(order).deliver

    if order.user.send_ship_email
      Delayed::Job.enqueue OrderShippingJob.new(order_id)
    end
  end
end
