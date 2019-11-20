# frozen_string_literal: true

# Reviews Controller
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authorize_user
  before_action :set_review, only: %i[update destroy]
  before_action :set_reviewable, only: %i[create]
  before_action :set_product

  def create
    @review = current_user.reviews.build(review_params)
    @review.reviewable = @reviewable
    authorize @review
    @review.save
    respond_to do |format|
      format.js
    end
  end

  def update
    authorize @review
    @review.update(review_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    authorize @review
    @review.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_reviewable
    @reviewable = if params[:review_id]
                    Review.find(params[:review_id])
                  elsif params[:product_id]
                    Product.find(params[:product_id])
                  end
  end

  def set_product
    @product = Product.find(params[:product])
  end
end
