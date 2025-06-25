class AllocationRulesController < ApplicationController
  def post_rule
    authorize AllocationRule
    schema = AllocationRules::PostRuleSchema.new
    data = schema.call(params.to_unsafe_h)
    if data.success?
      data = data.to_h
      category = Category.find_by(name: data[:category], user_id: current_user.id)
      data[:category] = category
      rule = AllocationRule.new(data)
      rule.user = current_user
      if rule.save
        render json: { success: true }, status: :created
      else
        render json: { errors: rule.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: data.errors.to_h }, status: :unprocessable_entity
    end
  end
end
