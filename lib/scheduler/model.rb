module Scheduler
  module Model
    extend ActiveSupport::Concern

    included do
      validates_presence_of :start_at, :end_at

      before_validation :fill_start_date
    end

    module InstanceMethods
      protected

      def fill_start_date
        self.start_date ||= start_at
      end
    end
  end
end
