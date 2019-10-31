# frozen_string_literal: true

# Products Controller
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    @product.category_id = 2
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
      flash[:notice] = 'Product Updated Successfully'
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = 'Product Deleted Successfully'
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :desc, :price, :qty)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
