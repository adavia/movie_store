class ProductsController < ApplicationController
  def index
    @products = Product.all
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
        format.html { render :index }
        format.js   {}
        format.json {
          render json: @product.errors, status: :unprocessable_entity
        }
      end
    end
  end
end
