module Aedile
  module Cli
    class ServiceCommands < ::Thor
      include Aedile::Thor

      desc "list", "shows all known services"
      def list
        client.service_names.each{|s| puts s }
      end

      desc "new NAME", "creates a new service named NAME"
      def new(name)

        service = client.get_service(name)
        die! "Service #{name} already exists: aborting" if service.exists?        

        result, new_config = *Util.edit_as_json(service.config)
        case result
        when :changed, :unchanged ; #noop, continue onto etcd write
        when :canceled ;
          die! "Creation canceled"
        when :unparsable ;
          new(name) if yes?("Unparsable JSON, try again? (y/N)")
          die! "Aborting"
        else ;
          die! "Unknown result: #{result}"
        end

        result = service.create(new_config)
        case result
        when :created ;         win! "Created service #{name}"
        when :already_exists ;  die! "Service #{name} already exists"
        else ;                  die! "Unknown result: #{result}"
        end


        # puts "TODO: ask for initial scale"
        # puts "TODO: set initial scale in etcd"
      end

      desc "delete NAME", "deletes service NAME"
      def delete(name)
        service = load_existing_service(name)

        win! if no?("Are you sure you want to delete service #{name}? (y/N)")

        result  = service.delete

        case result
        when :deleted ;       win! "Deleted service #{name}"
        when :doesnt_exist ;  die! "Service #{name} doesn't exist"
        else ;                die! "Unknown result: #{result}"
        end
      end

      desc "show NAME", "outputs the config for NAME to standard out"
      def show(name)
        service = load_existing_service(name)
        config  = service.config

        puts Util.dump_json(config)
      end

      desc "edit NAME", "opens config for NAME in current environment's editor for editing"
      def edit(name)
        service = load_existing_service(name)

        config  = service.config

        result, new_config = *Util.edit_as_json(config)

        case result
        when :changed ;
          set_result = service.set_config(new_config)

          case set_result
          when :updated ;         win! "Config for service #{name} updated"
          when :invalid_config ;  die! "Config for service #{name} would become invalid: aborting"
          else ;                  die! "Unknown result: #{set_result}"
          end

        when :canceled ;
          die! "Edit canceled"
        when :unchanged ;
          die! "Config for service #{name} unchanged: aborting"
        when :unparsable ;
          edit(name) if yes?("Unparsable JSON, try again? (y/N)")
          die! "Aborting"
        else
          die! "Unknown result: #{result}"
        end
      end

      desc "scale NAME SCALE", "changes the scale of NAME to SCALE"
      def scale(name, new_scale)
        service = load_existing_service(name)

        new_scale = Integer(new_scale)
        service.set_scale(new_scale)
        win! "scale for service #{name} set to #{new_scale}"
      rescue ArgumentError
        die! "Invalid scale #{new_scale.inspect}: aborting"
      end

      private
      def load_existing_service(name)
        service = client.get_service(name)
        die! "Service #{name} doesn't exist: aborting" unless service.exists?
        service
      end
    end
  end
end