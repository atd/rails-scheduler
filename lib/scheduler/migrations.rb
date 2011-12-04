module Scheduler
  class Migrations
    def initialize
      @migration = find_migration 'rails-scheduler'
    end

    def up
      # Run any available migration
      ::ActiveRecord::Migrator.migrate @migration
    end

    def down
      begin
        ::ActiveRecord::Migrator.migrate @migration, 0
      rescue
        puts "WARNING: Rails Scheduler failed to rollback"
      end
    end

    protected

    def find_migration(gem)
      File.join([get_full_gem_path(gem)], 'db/migrate')
    end

    def get_full_gem_path(gem)
      if (Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.8.0'))
        return Gem::Specification.find_by_name(gem).full_gem_path
      else
        return Gem::GemPathSearcher.new.find(gem).full_gem_path
      end
    end
  end
end
