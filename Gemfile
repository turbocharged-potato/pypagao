source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

### BASICS

# Ruby version
ruby '2.5.0'
# Rails version
gem 'rails', '~> 5.2.0'
# Use postgres as the database
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'

### END BASICS

### UTILITIES

# Environment variables
gem 'dotenv-rails', require: 'dotenv/rails-now'
# Mailgun
gem 'mailgun-ruby', '~> 1.1.6'

group :test do
  # Test coverage
  gem 'coveralls', require: false
end

group :development do
  # Generate Entity-Relationship Diagram
  gem 'rails-erd', require: false
  # Annotates model with schema
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Rspec testing framework
  gem 'rspec-rails'
  # Factory bot: factories for testing
  gem 'factory_bot_rails'
  # Shoulda Matchers: matchers for testing -- experimental gem for Rails 5
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  # Trace routes
  gem 'traceroute'
  # Optimize and cache expensive computations
  gem 'bootsnap', require: false
  # Swagger tooling
  gem 'rswag'
end

### END UTILITIES

### QUALITY

group :development, :test do
  # Ruby linter
  gem 'rubocop'
  # SCSS linter
  gem 'scss_lint', require: false
end

### END QUALITY

### MAINTENANCE

group :development do
  # Database profiler
  gem 'rack-mini-profiler'
end

group :production do
  # Auto-email exceptions
  gem 'exception_notification'
end

### END MAINTENANCE

### SECURITY

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Adds various security stuff. You need protection!
gem 'rack-protection'

group :development, :test do
  # Security checkup
  gem 'brakeman'
end

### END SECURITY

### SUGGESTED BY DEFAULT
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
### END SUGGESTION


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
