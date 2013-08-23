class OrdersController < ApplicationController
  before_filter :authorize

  def new
    @order = Order.new
  end

  def index
    @orders = current_user.orders
  end

  # TODO: this is where we would actually create the order and save it do the DB
  # TODO: this is also where we would submit a job to printful for this order
  def confirm
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
