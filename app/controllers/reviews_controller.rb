# frozen_string_literal: true

# Reviews Controller
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reviewable, only: %i[create destroy]

  def new
    @review = Review.new
  end

  def create
    @review = @reviewable.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_back(fallback_location: product_path(@reviewable),
                    notice: 'Review Was Succesfully Posted')
    else
      redirect_back(fallback_location: product_path(@reviewable),
                    notice: 'Failed to Post a Review')
    end
  end

  def edit; end

  def update; end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_back(fallback_location: product_path(@reviewable),
                    notice: 'Review Was Succesfully Deleted')
    else
      redirect_back(fallback_location: product_path(@reviewable),
                    notice: 'Failed to Delete a Review')
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
