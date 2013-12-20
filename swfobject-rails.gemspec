# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "swfobject/rails/version"

Gem::Specification.new do |s|
  s.name        = "swfobject-rails"
  s.version     = Swfobject::Rails::VERSION
  s.authors     = ["Corin Langosch"]
  s.email       = ["info@corinlangosch.com"]
  s.homepage    = "https://github.com/gucki/swfobject-rails"
  s.summary     = %q{Integration of swfobject with the Rails 3.x asset pipeline}
  s.description = %q{This gem integrates swfobject with the Rails 3.x asset pipeline.}
  s.license     = "MIT"

  s.rubyforge_project = "swfobject-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.0"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rake"
end
