class LineItemsController < ApplicationController
  include CurrentCart

  skip_before_action :authorize, only: :create
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to root_url }
        format.js   { @current_item = @line_item }
        format.json { render action: 'show',
          status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors,
          status: :unprocessable_entity }
      end
    end
  end
end
