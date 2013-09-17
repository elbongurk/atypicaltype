class OrderMailer < ActionMailer::Base
  default from: 'orders@atypicaltype.com'

  def confirmed(order)
    @order = order
    mail(to: @order.email, subject: "Order ##{@order.number} Confirmed")
  end

  def shipped(order)
    @order = order
    mail(to: @order.email, subject: "Order ##{@order.number} Shipped")
  end
end
