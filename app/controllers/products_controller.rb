# frozen_string_literal: true

# Products Controller
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[new index edit]
  before_action :set_products, only: %i[index]

  def index; end

  def show; end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = current_user.products.build(product_params)
    authorize @product
    if @product.save
      redirect_to @product
      flash[:notice] = 'Product Added Successfully'
    else
      render 'new'
      flash[:alert] = 'Failed to Add Product'
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to @product
      flash[:notice] = 'Product Updated Successfully'
    else
      render 'edit'
      flash[:alert] = 'Failed to Update'
    end
  end

  def destroy
    authorize @product
    if @product.destroy
      redirect_to products_path
      flash[:notice] = 'Product Deleted Successfully'
    else
      flash[:alert] = 'Failed to Delete'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :desc, :price, :qty, :category_id,
                                    images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_products
    @products = if params.key?(:category)
                  get_products_by_category(params[:category])
                else
                  Product.all
                end
  end

  def set_categories
    @categories = Category.all
  end

  def get_products_by_category(category)
    @category = Category.find_by(name: category)
    @products = if @category.parent_category.nil?
                  Product.where(category: @category.subcategories)
                else
                  Product.where(category: @category)
                end
    @products
  end
end
