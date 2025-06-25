module Transactions
  class PostTransactionSchema < Dry::Validation::Contract
    params do
      required(:amount).filled(:decimal)
      required(:description).filled(:string, max_size?: 300)
      required(:category).filled(:string, included_in?: %w[income expense fixed_income fixed_expense])
      required(:transacted_at).filled(:date)
    end
  end
end

