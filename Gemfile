source "http://rubygems.org"

# Declare your gem's dependencies in let_me_in.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'pg'

# jquery-rails is used by the dummy application
gem "jquery-rails"

gem 'omniauth-identity'
gem 'omniauth-instagram'
gem 'omniauth-twitter', '0.0.8'
gem 'omniauth-banters', :git => "git://github.com/becarella/omniauth-banters.git"

gem 'hbs'
gem 'handlebars_assets', :git => 'git://github.com/becarella/handlebars_assets.git'

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'sqlite3'
  gem 'simplecov', :require => false
  gem 'factory_girl_rails'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem "render_or_redirect", :git => "git://github.com/becarella/render_or_redirect.git"
