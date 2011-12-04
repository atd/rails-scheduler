require 'scheduler/migrations'

ActiveRecord::Migration.verbose = false

Scheduler::Migrations.new.down

Scheduler::Migrations.new.up
