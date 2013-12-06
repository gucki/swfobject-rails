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

  s.rubyforge_project = "swfobject-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "rails", ">=3.2"
end

