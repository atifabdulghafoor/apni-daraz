# frozen_string_literal: true

# Product Model
class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true
  validates :quantity, length: { minimum: 1 }
  validates :images, attached: true
  validates :images, content_type: %i[png jpeg jpg]
  validates :images, limit: { min: 1, max: 5 }

  resourcify
end
