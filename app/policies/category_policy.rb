class TransactionPolicy < ApplicationPolicy
  attr_reader :user, :transaction

  def initialize(user, transaction)
    super
    @user = user
    @transaction = transaction
  end

  def post_transaction?
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
