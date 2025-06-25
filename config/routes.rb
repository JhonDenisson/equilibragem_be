Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "/auth/generate_token" => "authentication#generate_token"
  post "/users" => "users#post_user"

  post "/transactions" => "transactions#post_transaction"
  post "/categories" => "categories#post_category"
  post "/rules" => "allocation_rules#post_rule"
  # Defines the root path route ("/")
  # root "posts#index"
end
