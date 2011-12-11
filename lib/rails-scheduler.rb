require "scheduler/version"
require 'recurrence'

module Scheduler
  autoload :ActiveRecord, 'scheduler/active_record'
  autoload :Model,        'scheduler/model'
end

require 'scheduler'
require 'scheduler/engine'
