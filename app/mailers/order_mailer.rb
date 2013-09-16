class OrderMailer < ActionMailer::Base
  default from: 'hello@atypicaltype.com'

  def confirmed(order)
    @order = order
    mail(to: @order.email, subject: "Order ##{@order.id} Confirmed")
  end

  def shipped(order)
    @order = order
    mail(to: @order.email, subject: "Order ##{@order.id} Shipped")
  end
end
