# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'bootsnap', require: false
gem 'chartkick'
gem 'httparty'
gem 'i18n'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'pry'
gem 'pry-rails'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8', '>= 7.0.8.1'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'view_component'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'rubocop', require: false
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem 'avo', '>= 3.2'
gem 'devise', '~> 4.9'

gem 'tailwindcss-rails', '~> 2.6'

gem 'pundit', '~> 2.3'
