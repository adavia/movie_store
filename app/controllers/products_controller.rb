class ProductsController < ApplicationController
  include CurrentCart
  skip_before_action :authorize, only: :index
  before_action :set_cart

  def index
    @products = Product.order(:title)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path }
        format.js   {}
        format.json {
          render json: @product, status: :created, location: @product
        }
      else
        format.html { render :new }
        format.js   {}
        format.json {
          render json: @product.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :url, :price)
  end
end
