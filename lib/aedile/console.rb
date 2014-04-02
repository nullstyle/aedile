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

    def service_created(service)
      puts "Created service #{service.name}"
    end

    def service_scaled(service, scale)
      puts "scale for service #{service.name} set to #{scale}"
    end

    def confirm_service_delete(service)
      agree("Are you sure you want to delete service #{service.name}? (y/n)")
    end

    def service_deleted(service)
      puts "Deleted service #{service.name}"
    end

    def service_config_updated(service)
      puts "Config for service #{service.name} updated"
    end

    def service_create_failed(failure_type, service)
      case failure_type
      when :aborted ;
        raise "Creation aborted"
      when :canceled ;
        raise "Creation canceled"
      when :already_exists ;
        raise "Service #{service.name} already exists"
      else
        raise failure_type.to_s
      end
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

    def service_not_found(name, throws=true)
      message = "Service '#{name}' doesn't exist"
      if throws
        raise message
      else
        puts message
      end
    end

    def list_services(names)
      names.each{|s| puts s }
    end

    # unit messages
    def unit_not_found(name)
      raise "Unit '#{name}' doesn't exist"
    end

    def unit_submitted(unit)
      puts "#{unit.unit_name} submitted to fleet"
    end

    def list_units(units)
      view units.map(&:status_hash), class: :tab_table, fields: [:UNIT, :STATUS]
    end

    def show_unit(unit)
      puts unit.unit_content
    end

    #
    def manager_installed
      puts "Aedile manager installed into fleet"
    end

    def manager_uninstalled
      puts "Aedile manager removed from fleet"
    end

    def manager_booted
      puts "=> Booting Aedile Manager - #{Aedile::VERSION}"
      puts "=> Performing Initial Sync..."
    end

    def manager_waiting_for_changes
      puts "=> Waiting for changes in config"
    end

    def manager_exiting
      puts "Exiting..."
    end
  end
end