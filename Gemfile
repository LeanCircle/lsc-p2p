source 'https://rubygems.org'
ruby '2.0.0'

gem 'sass-rails'
gem 'rails', '4.1.0'
gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'
gem 'haml-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder'
gem 'devise'

gem 'friendly_id', '~> 5.0.0' # For nice url slugs
gem 'activeadmin', github: 'gregbell/active_admin' # Basic admin panel
gem 'cancan' # for access control

# Various APIs
gem 'gibbon', '1.0.4' # For mailchimp integration
gem 'stripe', github: 'stripe/stripe-ruby' # For payments
gem 'gravatar_image_tag' # For user images
gem 'recaptcha', require: 'recaptcha/rails' # Add captcha to contact forms
gem 'geocoder' # To geolocate groups
gem 'gmaps4rails' # To make a pretty map of the groups
gem 'rmeetup', :git => 'git://github.com/pbajaria/rmeetup.git' # to talk to meetup's api

# Developer tools
gem 'figaro' # Config env variables with config/application.yml using config/application.yml.example
gem 'heroku_san' # Deploy scripst for heroku
gem 'newrelic_rpm' # Basic error notifications and dev metrics

group :development do
  gem 'sqlite3', '1.3.8'
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.17.0'
  gem 'rails_12factor', '0.0.2'
end