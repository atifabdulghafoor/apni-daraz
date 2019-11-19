# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :image

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :image, content_type: %i[png jpeg jpg]

  after_create :assign_default_role

  def assign_default_role
    add_role(:customer) if roles.blank?
  end
end
