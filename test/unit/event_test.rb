require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "includes Scheduler::Model" do
    assert Event.ancestors.include? Scheduler::Model
  end

  test "fills start_date" do
    assert Factory(:event).start_date.present?
  end

  test "interval_days" do
    e = Factory(:event)

    battery = {
      0   => [],
      1   => [0],
      2   => [1],
      3   => [0, 1],
      4   => [2],
      5   => [0, 2],
      127 => [0, 1, 2, 3, 4, 5, 6]
    }

    battery.each_pair do |flag, days|
      e.interval_flag = flag
      assert e.interval_days.eql?(days)

      e.interval_days = days
      assert e.interval_flag.eql?(flag)
    end
  end
end
