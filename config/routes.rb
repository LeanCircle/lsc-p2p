P2pc::Application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'subscribers#landing_page'

  # Static page routes
  [ :p2p,
    :about,
    :thanks,
    :guidelines,
    :team,
    :moderation_guidelines,
    :guidelines_espanol].each do |static_page|
    match "/#{static_page}", to: "static_pages##{static_page}", via: :get
  end
  match "faq.html" => "static_pages#guidelines", via: :get
  match "faq" => "static_pages#guidelines", via: :get
  match '/privacy-policy', to: 'static_pages#privacy', via: :get, as: :privacy

  resources :subscribers, only: [:create]  do
    get 'thanks', on: :collection
  end

  resources :users, only: [:new, :create, :edit, :update]
  resources :peers, only: [:new, :create, :update] do
      get 'registration', on: :member
  end

  resources :contact_messages, only: [:create]
  match "/contact-us", to: 'contact_messages#new', via: :get, as: :new_contact_message
  match "/thanks-for-contacting-us", to: 'contact_messages#thanks', via: :get, as: :contact_message_thanks

  # Group routes
  resources :groups, :except => [:edit, :update, :destroy]
end