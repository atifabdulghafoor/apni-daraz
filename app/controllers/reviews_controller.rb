# frozen_string_literal: true

# Reviews Controller
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reviewable, only: %i[create destroy]

  def create
    @review = current_user.reviews.build(review_params)
    @review.reviewable = @reviewable
    authorize @review
    if @review.save
      redirect_back(fallback_location: product_path(@reviewable),
                    notice: 'Review Was Succesfully Posted')
    else
      redirect_back(fallback_location: product_path(@reviewable),
                    alert: 'Failed to Post a Review')
    end
  end

  def edit; end

  def update; end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    if @review.destroy
      redirect_back(fallback_location: product_path(@reviewable),
                    notice: 'Review Was Succesfully Deleted')
    else
      redirect_back(fallback_location: product_path(@reviewable),
                    alert: 'Failed to Delete a Review')
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

  def set_reviewable
    if params[:review_id]
      @reviewable = Review.find(params[:review_id])
    elsif params[:product_id]
      @reviewable = Product.find(params[:product_id])
    end
  end
end
