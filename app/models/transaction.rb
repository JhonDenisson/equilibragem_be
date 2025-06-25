class Transaction < ApplicationRecord
  # Todos tipo de transação, incluindo entrada e saída
  belongs_to :user
  belongs_to :category

  enum :transaction_type, %i[income expense]
end
