class OrdersController < ApplicationController
  before_filter :authorize

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
