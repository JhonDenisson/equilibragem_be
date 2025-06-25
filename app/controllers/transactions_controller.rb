class TransactionsController < ApplicationController
  def post_transaction
    authorize Transaction
    schema = Transactions::PostTransactionSchema.new
    data = schema.call(params.to_unsafe_h)

    if data.success?
      data = data.to_h

      category = Category.find_by(name: data[:category])
      return render json: { error: "Category has not founded" }, status: :not_found if category.nil?
      data[:category] = category

      ActiveRecord::Base.transaction do

        transaction = Transaction.new(data.merge(category: category, user: current_user))
        unless transaction.save
          return render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
        transaction_date = transaction.transacted_at || transaction.created_at

        summary = Summary.find_or_initialize_by(
          user_id: current_user.id,
          month: transaction_date.month,
          year: transaction_date.year
        )

        if summary.persisted?
          unless summary.update_with_transaction(transaction)
            raise ActiveRecord::Rollback, "Failed to update summary"
          end
        else
          summary = Summary.generate_for_user(current_user, transaction_date)
          unless summary.persisted?
            raise ActiveRecord::Rollback, "Failed to create summary"
          end
        end

        render json: {
          success: true,
          transaction: transaction.as_json(only: [:id, :amount, :transaction_type, :date]),
          summary: summary.as_json(only: [:month, :year, :total_income, :total_expense, :balance])
        }, status: :created

      rescue ActiveRecord::Rollback => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

    else
      render json: { errors: data.errors.to_h }, status: :unprocessable_entity
    end
  end

  def get_transactions
    authorize Transaction
    transactions = policy_scope(Transaction)
    render json: transactions, each_serializer: Transactions::GetTransactionsSerializer, status: :ok
  end
end
