# frozen_string_literal: true

# Review Policy
class ReviewPolicy < ApplicationPolicy
  def create?
    return true unless admin? || moderator?
  end

  def show_links?
    return true if owner? || admin? || moderator?
  end

  def destroy?
    return true if owner? || admin? || moderator?
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
