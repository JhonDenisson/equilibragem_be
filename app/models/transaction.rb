class Transaction < ApplicationRecord
  #Todos tipo de transação, incluindo entrada e saída
  belongs_to :user
end
