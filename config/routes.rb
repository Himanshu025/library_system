Rails.application.routes.draw do
  resources :libraries
  resources :categories
  resources :books
  resources :issue_histories
  resources :members
end
