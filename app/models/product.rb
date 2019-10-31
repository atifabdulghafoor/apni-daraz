# frozen_string_literal: true

# Product Model
class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  resourcify
end
