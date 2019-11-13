# frozen_string_literal: true

# Category Model
class Category < ApplicationRecord
  belongs_to :parent_category, class_name: 'Category',
                               foreign_key: 'parent_id', optional: true,
                               inverse_of: 'subcategories'
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id',
                           dependent: :destroy, inverse_of: :parent_category
  has_many :products, dependent: :destroy
  scope :main, -> { where(parent_id: nil) }
  scope :subcategories, -> { where.not(parent_id: nil) }
  resourcify
end
