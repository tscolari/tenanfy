$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tenanfy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tenanfy"
  s.version     = Tenanfy::VERSION
  s.authors     = ["Tiago Scolari"]
  s.email       = ["tscolari@gmail.com"]
  s.homepage    = "https://github.com/tscolari/tenanfy"
  s.summary     = "Mult-Tenant drop and play solution."
  s.description = "Offers a opinated use of the Apartment gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency "apartment", ">= 0.25.0"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
end
