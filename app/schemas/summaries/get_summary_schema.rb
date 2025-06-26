module Summaries
  class GetSummarySchema < Dry::Validation::Contract
    params do
      optional(:month).filled(:string)
      optional(:year).filled(:string)
    end

    rule(:month, :year) do
      if values[:month].nil? && !values[:year].nil?
        key(:year).failure('Year cannot be provided without month')
      elsif !values[:month].nil? && values[:year].nil?
        key(:month).failure('Month cannot be provided without year')
      end
    end
  end
end
