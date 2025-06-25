class PostTransactionSchema < Dry::Validation::Contract
    params do
      required(:value).filled(:decimal)
      required(:description).filled(:string, max_size?: 300)
      required(:type).filled(:string, included_in?: %w[income expense])
      required(:date).filled(:date)
    end
end


