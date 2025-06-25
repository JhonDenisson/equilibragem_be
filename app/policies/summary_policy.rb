class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :category

  def initialize(user, category)
    super
    @user = user
    @category = category
  end

  def post_category?
    true
  end

  def get_categories?
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
