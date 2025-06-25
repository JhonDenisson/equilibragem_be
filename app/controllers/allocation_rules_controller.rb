class TransactionsController < ApplicationController
  def post_transaction
    authorize Transaction
    schema = Transactions::PostTransactionSchema.new
    data = schema.call(params.to_unsafe_h)
    if data.success?
      data = data.to_h
      category = Category.find_by(name: data[:category])
      data[:category] = category
      transaction = Transaction.new(data)
      transaction.user = current_user
      if transaction.save
        render json: { success: true }, status: :created
      else
        render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: data.errors.to_h }, status: :unprocessable_entity
    end
  end
end
