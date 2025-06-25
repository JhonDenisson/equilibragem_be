class UserPolicy < ApplicationPolicy
  attr_reader :user, :user_record

  def initialize(user, user_record)
    super
    @user = user
    @user_record = user_record
  end

  def post_user?
    true
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end

    private
    attr_reader :user, :scope
  end
end
