P2pc::Application.routes.draw do

  root 'subscribers#landing_page'

  match '/p2p', to: 'static_pages#p2p', via: :get
  match '/about', to: 'static_pages#about', via: :get
  match '/team', to: 'static_pages#team', via: :get
  match '/thanks', to: 'static_pages#thanks', via: :get
  match '/privacy-policy', to: 'static_pages#privacy', via: :get, as: :privacy

  resources :subscribers, only: [:create]  do
    get 'thanks', on: :collection
  end

  resources :peers, only: [:new, :create, :update] do
      get 'registration', on: :member
  end

  resources :contacts, only: [:create]
  match "/contact", to: 'contacts#new', via: :get
  match "/contact/thanks", to: 'contacts#thanks', via: :get
end
