# frozen_string_literal: true

# Review Model
class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  has_many :reviews, as: :reviewable, dependent: :destroy

  validates :content, presence: true

  resourcify
end
