Rails.application.routes.draw do
  get 'search/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'search#index'
end
