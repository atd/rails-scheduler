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
  s.summary     = "Provide a Rails application with support for scheduled events"
  s.description = "Scheduler support: daily, weekly and montly repetitions"

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency "recurrence", '~> 1.2.0'

  s.add_development_dependency "mysql2"
  s.add_development_dependency "factory_girl", '~> 1.3.2'
end
