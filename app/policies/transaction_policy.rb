class CompanyAffiliatePolicy < ApplicationPolicy
  attr_reader :user, :company_affiliate

  def initialize(user, company_affiliate)
    super
    @user = user
    @company_affiliate = company_affiliate
  end

  def get_splits?
    true
  end

  def post_split?
    true
  end

  def put_split?
    company_affiliate.company_id == user.company_id
  end


  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(company_id: user.company_id)
    end

    private
    attr_reader :user, :scope
  end
end
