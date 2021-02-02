Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#create'
  post 'sign_up', to: 'registrations#create'
end
