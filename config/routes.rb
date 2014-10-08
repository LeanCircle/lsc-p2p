P2pc::Application.routes.draw do

  root "subscribers#landing_page"

  ActiveAdmin.routes(self)

  devise_for :users
  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    delete "sign_out", to: "devise/sessions#destroy"
  end

  resources :users, only: [:new, :create, :edit, :update] do
    get "team", on: :collection
  end

  resources :subscribers, only: [:create]  do
    get "thanks", on: :collection
  end

  resources :contact_messages, only: [:create]
  get "contact-us", to: "contact_messages#new", as: :new_contact_message
  get "thanks-for-contacting-us", to: "contact_messages#thanks", as: :contact_message_thanks

  resources :groups, except: [:edit, :update, :destroy]

  resources :links, except: [:edit, :update,:destroy] do
    post "upvote", to: "links#upvote"
    post "downvote", to: "links#downvote"
  end

  # Static page routes
  [ :about,
    :thanks,
    :guidelines,
    :moderation_guidelines,
    :guidelines_espanol,
    :cookie ].each do |static_page|
    get "#{static_page}", to: "static_pages##{static_page}"
  end
  get "faq.html", to: "static_pages#guidelines"
  get "faq", to: "static_pages#guidelines"
  get "privacy-policy", to: "static_pages#privacy", as: :privacy

  # Redirect routes
  get 'peers/new', to: redirect('/')
  get 'p2p', to: redirect('/')
  get "thanks", to: redirect('/')
  
end