class Category < ApplicationRecord
  #Tipos de transação: entrada, saída, despesa fixa
  belongs_to :transaction
end
