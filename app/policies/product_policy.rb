# frozen_string_literal: true

# Product Policy
class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def initialize(user, product)
    super
    raise Pundit::NotAuthorizedError.new(policy: 'product') unless admin?

    @user = user
    @product = product
  end
end
