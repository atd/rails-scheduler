module Scheduler
  module Model
    extend ActiveSupport::Concern

    included do
      validates_presence_of :start_at, :end_at

      before_validation :fill_scheduler_dates

      validates_presence_of :interval,
                            :if => lambda { |record|
        [ :weekly ].include? record.frequency_sym
      }
      
      validates_numericality_of :interval_flag,
                                :greater_than => 0,
                                :if => lambda { |record|
        [ :weekly ].include? record.frequency_sym
      }

      scope :between, lambda { |start_time, end_time|
        where('start_date <= ?', end_time).
        where(arel_table[:end_date].eq(nil).or(arel_table[:end_date].gteq(start_time)))
      }
    end

    module InstanceMethods
      def frequency_sym
        Scheduler::FREQUENCIES[frequency]
      end

      # Get [ 0, 1, 6 ] (monday, tuesday, sunday) from byte
      def interval_days
        7.times.map{ |i|
          interval_flag[i] > 0 ?
          i :
          nil
        }.compact
      end

      def interval_days_sym
        interval_days.map{ |d|
          Date::DAYS_INTO_WEEK.invert[d]
        }
      end

      # Convert [ 0, 1, 6 ] (monday, tuesday, sunday) to byte
      def interval_days= days
        self.interval_flag =
          days.map{ |d| 2 ** d.to_i }.inject(0, &:+)
      end

      def recurrence
        case frequency_sym
        when :weekly
          Recurrence.new({ :every    => :week,
                           :starts   => start_date.to_date,
                           :until    => end_date.try(:to_date),
                           :interval => interval,
                           :on       => interval_days_sym })
        end
      end

      protected

      def fill_scheduler_dates
        self.start_date ||= start_at

        self.end_date = end_at if frequency == 0
      end
    end
  end
end
