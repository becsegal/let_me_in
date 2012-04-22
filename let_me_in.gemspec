$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "let_me_in/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "let_me_in"
  s.version     = LetMeIn::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of LetMeIn."
  s.description = "TODO: Description of LetMeIn."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.4"
  s.add_dependency 'bcrypt-ruby', '~> 3.0.0'
  
  s.add_dependency 'omniauth-identity'
  s.add_dependency 'omniauth-twitter'
  s.add_dependency 'omniauth-instagram'

  s.add_development_dependency "sqlite3"
end
