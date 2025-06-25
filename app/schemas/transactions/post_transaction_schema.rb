module Transactions
  class PostTransactionSchema < Dry::Validation::Contract
    params do
      required(:amount).filled(:decimal)
      required(:description).filled(:string, max_size?: 300)
      required(:transaction_type).filled(:string, included_in?: %w[income expense])
      required(:category).filled(:string)
      required(:transacted_at).filled(:date)
    end
  end
end

