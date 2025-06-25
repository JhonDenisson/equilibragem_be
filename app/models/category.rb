class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :transactions

  enum :category_type, %i[income expense fixed_income fixed_expense]
end
