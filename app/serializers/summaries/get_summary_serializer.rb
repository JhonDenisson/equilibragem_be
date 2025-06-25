module Summaries
  class GetSummarySerializer < ActiveModel::Serializer
    attributes :month, :year, :total_income, :total_expense, :balance
  end
end

