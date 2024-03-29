# frozen_string_literal: true

# Product Model
class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews, as: :reviewable, dependent: :destroy
  resourcify
end
