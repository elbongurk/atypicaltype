class OrdersController < ApplicationController
  before_filter :authorize

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.closed.find(params[:id])
  end

  def new
    @order = current_user.cart.orders.new(name: current_user.name)
  end

  def create
    @order = current_user.cart.orders.new(create_params)

    if @order.save
      redirect_to purchase_order_url(@order)
    else
      render action: :new
    end
  end

  def purchase
    @order = current_user.orders.open.find(params[:id])
  end

  def confirm
    @order = current_user.orders.open.find(params[:id])

    begin
      @result = Braintree::TransparentRedirect.confirm(request.query_string)
    rescue Braintree::BraintreeError
      return redirect_to purchase_order_url(@order)
    end

    if @result.success?
      @order.close(@result.transaction.id)
      redirect_to order_url(@order)
    else
      render action: :purchase
    end
  end

  private

  def create_params
    params
      .require(:order)
      .permit(:name, :email, :address1, :address2, :city, :state, :postal_code)
  end
end
