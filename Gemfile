source 'https://rubygems.org'
ruby '2.0.0'

# PostgreSQL driver
gem 'pg'

# Sinatra driver
gem 'sinatra'
gem 'sinatra-contrib'

gem 'activesupport', '~>4.1'
gem 'activerecord', '~>4.1'

gem 'rake'

gem 'shotgun'

gem 'bcrypt'
gem 'rest-client'
gem 'json'
# gem 'dotenv'
gem 'pry'
gem 'thin'


group :test do
  gem 'shoulda-matchers'
  gem 'rack-test'
  gem 'rspec'
  gem 'capybara'
end

group :test, :development do
  gem 'factory_girl'
  gem 'faker'
end

group :production do
  gem 'thin'  
end
