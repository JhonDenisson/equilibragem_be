class SummaryPolicy < ApplicationPolicy
  attr_reader :user, :summary

  def initialize(user, summary)
    super
    @user = user
    @summary = summary
  end

  def get_summary?
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
