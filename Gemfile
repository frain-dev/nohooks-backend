source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

gem 'dotenv-rails'
gem 'pg', '>= 0.18', '< 2.0'

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# HTTP Things
gem 'httparty'

# Interactors
gem 'interactor', '~> 3.0'

# Sidekiq for background processing
gem 'sidekiq'

# For periodic cron jobs
gem 'clockwork'                                     
                                                    
# For ActiveRecord Datetime filtering               
gem 'by_star', git: 'https://github.com/radar/by_star'
                                                    
# Use Rack CORS                                     
gem 'rack-cors', require: 'rack/cors'               
                                                    
# Sentry                                            
gem 'sentry-ruby'                                   
gem 'sentry-rails'                                  
gem 'sentry-sidekiq'                                
                                                    
# Batching                                          
gem 'batch-loader'                                  
                                                    
# API Serialization                                 
gem 'active_model_serializers', '~> 0.10.0'         
                                                    
# Connection Pool                                   
gem 'connection_pool'      

# Render Client
gem 'render_ruby'
gem 'faraday'

# Notion Client
gem 'notion-ruby-client'

# Google PubSub
# gem 'google-cloud-pubsub'
# gem 'grpc'
gem 'convoy.rb'

# User management
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem "omniauth-rails_csrf_protection"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "pry"
  gem "rspec-rails"
  gem "rspec_junit_formatter"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Annotation
  gem 'annotate'

  # Automatically run my tests. :)
  gem 'guard'
  gem 'guard-rspec', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"

  gem 'shoulda'
  gem 'faker'
end
