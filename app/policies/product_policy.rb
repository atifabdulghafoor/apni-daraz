# frozen_string_literal: true

# Product Policy
class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def new?
    admin?
  end

  def create?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def show?
    admin?
  end

  def destroys?
    admin?
  end

  private

  def admin?
    user.has_role? :admin
  end
end
