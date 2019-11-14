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

  def show_form?
    return true unless admin? || moderator?
  end

  def update?
    return true if owner?
  end

  def show_destroy_link?
    return true if owner? || admin? || moderator?
  end

  def show_update_link?
    return true if owner?
  end

  private

  def admin?
    user&.has_role? :admin
  end

  def moderator?
    user&.has_role? :moderator
  end

  def owner?
    return true if user == review.user
  end

  def customer?
    user&.has_role? :customer
  end

  def review
    record
  end
end
