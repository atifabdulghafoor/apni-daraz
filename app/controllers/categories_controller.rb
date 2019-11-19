# frozen_string_literal: true

# Categories controller
class CategoriesController < ApplicationController
  def categories_list
    @categories = Category.where(parent_id: params[:parent_id])

    respond_to do |format|
      format.json do
        render json: { subcategories: @categories.pluck(:id, :name) }
      end
    end
  end
end
