module Aedile
  class Console
    def self.current
      Thread.current[:aedile_notifier] ||= new()
    end


    include Hirb::Console

    # sync related messages
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

    # service messages

    def confirm_service_delete(service)
      agree("Are you sure you want to delete service #{service.name}? (y/n)")
    end

    def service_deleted(service)
      puts "Deleted service #{service.name}"
    end

    def service_config_updated(service)
      puts "Config for service #{service.name} updated"
    end

    def service_config_edit_failed(failure_type, service)
      case failure_type
      when :invalid ;
        raise "Config for service #{service.name} would become invalid"
      when :aborted ;
        raise "Edit aborted"
      when :canceled ;
        raise "Edit canceled"
      when :unchanged ;
        raise "Config for service #{service.name} unchanged"
      else
        raise failure_type.to_s
      end
    end

    def service_not_found(name)
      raise "Service '#{name}' doesn't exist"
    end


    # unit messages
    def unit_not_found(name)
      raise "Unit '#{name}' doesn't exist"
    end
  end
end