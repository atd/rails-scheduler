require "scheduler/version"

module Scheduler
  autoload :ActiveRecord, 'scheduler/active_record'
  autoload :Model,        'scheduler/model'
  # Your code goes here...
end

require 'scheduler/engine'
