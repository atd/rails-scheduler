require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "includes Scheduler::Model" do
    assert Event.ancestors.include? Scheduler::Model
  end
end
