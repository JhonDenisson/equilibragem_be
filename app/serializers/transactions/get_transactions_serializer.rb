module Transactions
  class GetTransactionsSerializer < ActiveModel::Serializer
    attributes :transaction_type, :description, :amount, :transacted_at
  end
end

