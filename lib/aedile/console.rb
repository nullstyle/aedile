module Aedile
  class Console
    def self.current
      Thread.current[:aedile_notifier] ||= new()
    end


    include Hirb::Console

    # sync related outputs
    def sync_started
      puts "=> Syncing with fleet:"
    end

    def sync_successful
      puts "=> Sync with fleet successful!"
    end

    def sync_errored(e)
      puts "=> Sync with fleet errored:"
      puts e.message
      puts e.backtrace
    end

    def unit_sync_started(unit_name)
      puts "  syncing #{unit_name}"
    end

    def unit_delete_started(unit_name)
      puts "  deleting #{unit_name}"
    end

    # service commands

    def confirm_service_delete(service)
      agree("Are you sure you want to delete service #{service.name}? (y/n)")
    end

    def service_deleted(service)
      puts "Deleted service #{service.name}"
    end

    def service_not_found(name)
      raise "Service '#{name}' doesn't exist"
    end

  end
end