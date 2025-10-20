class Summary < ApplicationRecord
  belongs_to :user

  validates :month, inclusion: { in: 1..12 }
  validates :year, numericality: { greater_than: 0 }
  validates :total_income, :total_expense, :balance, numericality: true

  def self.generate_for_user(user, date = Date.current)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    transactions = Transaction.where(user_id: user.id, transacted_at: start_date..end_date)

    total_income = transactions.where(transaction_type: 0).sum(:amount)
    total_expense = transactions.where.not(transaction_type: 0).sum(:amount)
    balance = total_income - total_expense

    create(
      user_id: user.id,
      month: date.month,
      year: date.year,
      total_income: total_income,
      total_expense: total_expense,
      balance: balance,
    )
  end

  def update_with_transaction(transaction)

    return false unless transaction&.transacted_at && transaction.transacted_at.month == month && transaction.transacted_at.year == year

    if transaction.income?
      self.total_income += transaction.amount
    else
      self.total_expense += transaction.amount
    end
    self.balance = total_income - total_expense
    save
  end
end
