class OrderSettlementJob < Struct.new(:order_id)
  def perform
    order = Order.find(order_id)

    Braintree::Transaction.submit_for_settlement!(order.transaction_id)

    Delayed::Job.enqueue OrderConfirmationJob.new(order_id)
  end
end
