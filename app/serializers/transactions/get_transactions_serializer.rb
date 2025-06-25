module Categories
  class GetCategoriesSerializer < ActiveModel::Serializer
    attributes :id, :name, :category_type
  end
end

