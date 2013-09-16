class OrderShippingJob < Struct.new(:order_id)
  def perform
    order = Order.find(order_id)
    porder = Printful::Order.find!(order.number)

    diff = porder.fulfilments.size - order.fulfillments.size

    if diff > 0
      porder.fulfilments.take(diff).each do |f|
        order.fullfillments.create!(service: f.service, tracking_code: f.trackingCode, shipped_on: f.shippingDate)
      end
      OrderMailer.shipped(porder).deliver
    else
      Delayed::Job.enqueue self, run_at: Time.now + 1.hours
    end
  end
end
