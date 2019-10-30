# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy

  after_create :assign_default_role

  def assign_default_role
    add_role(:customer) if roles.blank?
  end
end
