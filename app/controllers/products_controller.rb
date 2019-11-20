# frozen_string_literal: true

# Products Controller
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_categories, except: %i[destroy]
  before_action :set_products, only: %i[index]

  def index; end

  def show; end

  def new
    @product = Product.new
    authorize @product, :admin?
  end

  def create
    @product = current_user.products.build(product_params)
    authorize @product, :admin?
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit
    authorize @product, :admin?
  end

  def update
    authorize @product, :admin?
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    authorize @product, :admin?
    redirect_to products_path if @product.destroy
  end

  def search
    get_products_by_search(params[:search])
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity,
                                    :category_id, images: [])
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

  def get_products_by_search(search)
    search = "%#{search.downcase}%"
    @products = Product.where('lower(name) LIKE ? OR lower(description) LIKE ?',
                              search, search)
    @products
  end
end
