# frozen_string_literal: true

# Category Model
class Category < ApplicationRecord
  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id',
                           dependent: :destroy, inverse_of: :parent_category
  has_many :products, dependent: :destroy
  resourcify
end
