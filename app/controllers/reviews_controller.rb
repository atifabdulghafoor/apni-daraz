# frozen_string_literal: true

# Reviews Controller
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  befor_action :set_reviewable, only: %i[create]

  def new
    @review = Review.new
  end

  def create
    @review = @reviewable.replies.build(review_params)
    if @review.save
      redirect_to :back, notice: 'Review Was Succesfully Posted'
    else
      redirect_to :back, notice: 'Failed to Post the Review'
    end
  end

  def edit; end

  def update; end

  def destroy; end

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
