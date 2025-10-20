module Transactions
  class GetTransactionsSerializer < ActiveModel::Serializer
    attributes :id, :transaction_type, :description, :amount, :transacted_at
  end
end

