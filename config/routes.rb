P2pc::Application.routes.draw do

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

  resources :contacts, only: [:create]
  match "/contact", to: 'contacts#new', via: :get
  match "/contact/thanks", to: 'contacts#thanks', via: :get

  # Group routes
  resources :groups, :except => [:edit, :update, :destroy]
end
