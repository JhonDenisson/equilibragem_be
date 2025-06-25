module V1::Transactions
  class PostAccountSchema < Dry::Validation::Contract
    params do
      required(:document).filled(:string)
      required(:name).filled(:string, max_size?: 100)
      required(:phone).filled(:string, format?: /\A\d{10,11}\z/)
      required(:email).filled(:string, format?: URI::MailTo::EMAIL_REGEXP)
    end

    rule(:document) do
      if value
        key.failure('CPF must be valid') unless CPF.valid?(value)
        key.failure('must have 11 characters') unless value.length == 11
        key.failure('must have only numbers') unless value.match?(/^\d+$/)
      end
    end
  end
end


