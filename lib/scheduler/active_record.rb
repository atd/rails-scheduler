module Scheduler
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def scheduler
        include Scheduler::Model
      end
    end
  end
end
