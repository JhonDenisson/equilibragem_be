module Categories
  class PostCategorySchema < Dry::Validation::Contract
    params do
      required(:name).filled(:string, max_size?: 100)
      required(:category_type).filled(:string, included_in?: %w[income expense fixed_income fixed_expense])
    end
  end
end

