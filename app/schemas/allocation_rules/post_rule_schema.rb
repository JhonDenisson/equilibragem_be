module AllocationRules
  class PostRuleSchema < Dry::Validation::Contract
    params do
      required(:percentage).filled(:integer)
      required(:category).filled(:string)
    end
  end
end

