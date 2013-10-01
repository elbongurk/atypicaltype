class OrderSettlementJob < Struct.new(:order_id)
  def perform
    order = Order.find(order_id)

    Braintree::Transaction.submit_for_settlement!(order.transaction_id)

    if order.user.send_confirm_email
      Delayed::Job.enqueue OrderConfirmationJob.new(order_id)
    elsif order.user.send_ship_email
      Delayed::Job.enqueue OrderShippingJob.new(order_id)
    end
  end
end
