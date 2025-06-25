class CategoriesController < ApplicationController
  def post_category
    authorize Category
    schema = Categories::PostCategorySchema.new
    data = schema.call(params.to_unsafe_h)
    if data.success?
      data = data.to_h
      data[:category_type] = data[:category_type].to_sym
      category = Category.new(data)
      category.user = current_user
      if category.save
        render json: { success: true }, status: :created
      else
        render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: data.errors.to_h }, status: :unprocessable_entity
    end
  end

  def get_categories
    authorize Category
    categories = policy_scope(Category)
    render json: categories, each_serializer: Categories::GetCategoriesSerializer, status: :ok
  end
end
