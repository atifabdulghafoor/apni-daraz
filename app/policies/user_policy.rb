# frozen_string_literal: true

# User Policy
class UserPolicy < ApplicationPolicy
  def index?
    user.has_role? :admin
  end
end
