module AllocationRules
  class GetRulesSerializer < ActiveModel::Serializer
    attributes :id, :category, :percentage
    def category
      object.category.name
    end
  end
end

