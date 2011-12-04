require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "includes Scheduler::Model" do
    assert Event.ancestors.include? Scheduler::Model
  end

  test "fills start_date" do
    assert Factory(:event).start_date.present?
  end
end
