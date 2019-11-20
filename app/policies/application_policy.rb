# frozen_string_literal: true

# Application Policy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def method_missing(_name, *args)
    true || super
  end

  def respond_to_missing?(*_args)
    true
  end

  def admin?
    user && (user.has_role? :admin)
  end

  def moderator?
    user && (user.has_role? :moderator)
  end

  # Appication Policy > Scope
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
