class OrderConfirmationJob < Struct.new(:order_id)
  def perform
    order = Order.find(order_id)
    
    OrderMailer.confirmed(order).deliver

    Delayed::Job.enqueue OrderShippingJob.new(order_id)
  end
end
