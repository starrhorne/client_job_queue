$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "client_job_queue/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "client_job_queue"
  s.version     = ClientJobQueue::VERSION

  s.authors       = ["Starr Horne"]
  s.email         = ["starr@honeybadger.io"]
  s.description   = %q{Invoke JS workers from your Rails controllers}
  s.summary       = %q{Ever need to use GA or another analytics service to track an event that happened in your controller? This rails engine lets you do so in a clean way.}
  s.homepage      = "https://www.honeybadger.io"

  s.files = Dir["{app,config,db,lib,vendor/assets}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2"
  s.add_development_dependency "sqlite3"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "guard-jasmine"
  s.add_development_dependency "jasmine"
  s.add_development_dependency "rb-fsevent"
  
end
