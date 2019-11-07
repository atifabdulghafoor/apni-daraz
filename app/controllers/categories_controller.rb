# frozen_string_literal: true

# Categories controller
class CategoriesController < ApplicationController
  respond_to :json
  def categories_list
    @categories = if params[:parent_id]
                    Category.where(parent_id: params[:parent_id])
                  else
                    Category.all
                  end

    respond_with(@categories) do |format|
      format.json { render json: @categories.to_json(only: %i[id name]) }
    end
  end
end
