# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scheduler/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-scheduler"
  s.version     = Scheduler::VERSION
  s.authors     = ["Antonio Tapiador del Dujo"]
  s.email       = ["atapiador@dit.upm.es"]
  s.homepage    = "https://github.com/atd/rails-scheduler"
  s.summary     = "TODO: Summary of RailsScheduler."
  s.description = "TODO: Description of RailsScheduler."

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.1.0"

  s.add_development_dependency "sqlite3"
end
