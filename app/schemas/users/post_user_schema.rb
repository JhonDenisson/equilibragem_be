module Users
  class PostUserSchema < Dry::Validation::Contract
    params do
      required(:name).filled(:string)
      required(:email).filled(:string, format?: URI::MailTo::EMAIL_REGEXP)
      required(:password).filled(:string)
      required(:password_confirmation).filled(:string)
    end

    rule(:password, :password_confirmation) do
      key.failure('password and password_confirmation must be equal') unless values[:password] == values[:password_confirmation]
    end
  end
end
