class AllocationRulePolicy < ApplicationPolicy
  attr_reader :user, :allocation_rule

  def initialize(user, allocation_rule)
    super
    @user = user
    @allocation_rule = allocation_rule
  end

  def post_rule?
    true
  end

  def get_rules?
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
