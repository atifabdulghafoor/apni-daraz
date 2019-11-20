# frozen_string_literal: true

# Review Policy
class ReviewPolicy < ApplicationPolicy
  def create?
    return true unless (admin? || moderator?) &&
                       (review.reviewable_type == 'Product')
  end

  def destroy?
    return true if owner? || admin? || moderator?
  end

  def update?
    return true if owner?
  end

  private

  def admin?
    user && (user.has_role? :admin)
  end

  def moderator?
    user && (user.has_role? :moderator)
  end

  def owner?
    user && (user == review.user)
  end

  def customer?
    user.has_role? :customer
  end

  def review
    record
  end
end
