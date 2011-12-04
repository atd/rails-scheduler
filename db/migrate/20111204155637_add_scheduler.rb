class AddScheduler < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.date     :start_date
      t.date     :end_date
      t.integer  :frequency
      t.integer  :interval
      t.integer  :interval_flag
    end
  end

  def down
    drop_table :events
  end
end
