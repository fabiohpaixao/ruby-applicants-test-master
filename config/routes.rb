Rails.application.routes.draw do
	root :to => 'home#index'
  get "/" => "home#index"
  post "/models" => "models#index"
end
