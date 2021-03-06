class OrderFulfillmentJob < Struct.new(:order_id)
  include Rails.application.routes.url_helpers

  def self.default_url_options
    ActionMailer::Base.default_url_options
  end

  def perform
    order = Order.find(order_id)
    
    items = order.line_items.map do |line_item|
      url = photo_variant_url(line_item.photo, line_item.variant, format: :png)

      # FIXME: Hack due to the fact that the Printful API doesn't have a sandbox and requires a live URL
      if Rails.env.development?
        url = 'http://www.irs.gov/pub/irs-pdf/fw4.pdf'
      end

      item = {
        product: line_item.variant.number,
        imageUrl: url,
        sku: line_item.variant.sku,
        name: line_item.variant.product.description,
        quantity: line_item.quantity
      }
    end

    recipient = { fullName: order.name, address1: order.address1, address2: order.address2,
                  city: order.city, state: order.state, zip: order.postal_code, country: order.country }

    Printful::Order.create!(number: order.number, recipient: recipient, items: items)

    Delayed::Job.enqueue OrderSettlementJob.new(order_id)
  end
end
