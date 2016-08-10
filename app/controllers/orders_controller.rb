class OrdersController < ApplicationController
  include CurrentCart

  skip_before_action :authorize, only: [:new, :create]
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "Your cart is empty"
      return
    end

    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.ip_address = request.remote_ip
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        if @order.purchase(@cart)
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil

          OrderNotifierMailer.received(@order).deliver_later

          format.html { redirect_to root_url, notice:
            'Thank you for your order.' }
          format.json { render action: 'show', status: :created,
            location: @order }
        else
          format.html { render action: 'new' }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors,
          status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :email,
      :card_type, :card_number, :card_verification, :card_expires_on)
  end
end
