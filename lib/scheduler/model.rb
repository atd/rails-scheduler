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
      
      validates_numericality_of :days,
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
      def week_days
        7.times.map{ |i|
          days[i] > 0 ?
          i :
          nil
        }.compact
      end

      def week_day
        week_days.first
      end

      def week_days_sym
        week_days.map{ |d|
          Date::DAYS_INTO_WEEK.invert[d]
        }
      end

      def week_day_sym
        week_days_sym.first
      end

      # Convert [ 0, 1, 6 ] (monday, tuesday, sunday) to byte
      def week_days= ds
        self.days =
          ds.map{ |d| 2 ** d.to_i }.inject(0, &:+)
      end

      def week_day= day
        self.week_days = Array.wrap(day)
      end

      def week_day_order
        interval_flag
      end

      def week_day_order_sym
        index = interval_flag
        index -= 1 if index > 0

        Scheduler::ORDER[index]
      end

      def week_day_order= order
        self.interval_flag = order
      end

      # Array including all the dates this Scheduler has ocurrences
      # between st and en
      def ocurrences(st, en = nil)
        recurrence ?
          recurrence.events(:starts => st, :until => en) :
          (start_at.to_date..end_at.to_date).to_a
      end

      def recurrence
        case frequency_sym
        when :weekly
          Recurrence.new({ :every    => :week,
                           :starts   => start_date.to_date,
                           :until    => end_date.try(:to_date),
                           :interval => interval,
                           :on       => week_days_sym })
        when :monthly
          Recurrence.new({ :every    => :month,
                           :starts   => start_date.to_date,
                           :until    => end_date.try(:to_date),
                           :interval => interval,
                           :on       => week_day_order_sym,
                           :weekday => week_day_sym })
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
