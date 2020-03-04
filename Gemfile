source 'http://rubygems.org'

# Framework
gem 'sinatra', '2.0.1'

# Views
gem 'json'
gem 'sass', '3.7.3'
gem 'haml'
gem 'coffee-script'

gem 'sprockets', '3.7.1'

# Bootstrap
gem 'bootstrap', '~> 4.3.1'

# Server
gem 'puma', '3.12.4'

# Model
gem 'ffi'
gem 'excel_to_code', '>= 0.3.16'
# Model is now contained inside this source
# gem 'decc_2050_model', '3.5.0'
# gem 'india_2052_model',  :git => '../india_2052_model', :branch => 'master'
# gem 'india_2052_model', '1.0.6pre'

group :development do
  # Rack reloader
  gem 'shotgun'

  # Minifier
  gem 'yui-compressor'
  gem 'uglifier'#, '>= 1.0.3'

  #deployment
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'
end

group :test do
  gem 'minitest'
  gem 'rack-test'
  gem 'capybara-webkit'
  gem 'launchy'
end
