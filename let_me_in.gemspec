$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "let_me_in/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "let_me_in"
  s.version     = LetMeIn::VERSION
  s.authors     = ["Becky Carella"]
  s.email       = ["becarella@gmail.com"]
  s.homepage    = "https://github.com/becarella/let_me_in"
  s.summary     = "Modules and controllers for user identification"
  s.description = "Base controllers and modules for allowing users to signin/up with username/password or 3rd party via omniauth"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails"
  s.add_dependency 'bcrypt-ruby', '~> 3.0.0'
  s.add_dependency 'omniauth-identity'

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end
