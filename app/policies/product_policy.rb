# frozen_string_literal: true

# Product Policy
class ProductPolicy < ApplicationPolicy
  def admin?
    user && (user.has_role? :admin)
  end

  private

  def product
    record
  end
end
