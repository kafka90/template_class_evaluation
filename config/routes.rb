Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  root :to => 'main#main_test'

  get  ':controller(/:action(/:id))'
  post ':controller(/:action(/:id))'
end
