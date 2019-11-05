# frozen_string_literal: true

# Review Model
class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  has_many :replies, as: :reviewable, dependent: :destroy
  resourcify
end