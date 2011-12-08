module Scheduler
  class Engine < ::Rails::Engine #:nodoc:

    initializer "scheduler.active_record" do
      ActiveSupport.on_load(:active_record) do
        include Scheduler::ActiveRecord
      end
    end
  end
end
