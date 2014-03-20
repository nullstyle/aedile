module Aedile
  module Cli
    class ServiceCommands < Thor

      desc "list", "shows all known services"
      def list
        Aedile.client.service_names.each{|s| puts s }
      end

      desc "new NAME", "creates a new service named NAME"
      def new(name)
        # puts "TODO: open an editor to set the beginning config"
        # puts "TODO: commit config to etcd"
        # puts "TODO: ask for initial scale"
        # puts "TODO: set initial scale in etcd"
        service = Aedile.client.get_service(name)
        result  = service.create({})
        case result
        when :created ;
          puts "Created service #{name}"
        when :already_exists ;
          puts "Service #{name} already exists"
          exit 1
        else
          puts "Unknown result: #{result}"
          exit 1
        end
      end

      desc "delete NAME", "deletes service NAME"
      def delete(name)
        exit 0 if no?("Are you sure you want to delete service #{name}? (y/N)")

        service = Aedile.client.get_service(name)
        result  = service.delete

        case result
        when :deleted ;
          puts "Deleted service #{name}"
        when :doesnt_exist ;
          puts "Service #{name} doesn't exist"
          exit 1
        else
          puts "Unknown result: #{result}"
          exit 1
        end
      end

      desc "show NAME", "outputs the config for NAME to standard out"
      def show(name)
        service = Aedile.client.get_service(name)
        config  = service.config

        puts Util.dump_json(config)
      end

      desc "edit NAME", "opens config for NAME in current environment's editor for editing"
      def edit(name)
        puts "TODO: load config from etcd"
        puts "TODO: open an editor to change config"
        puts "TODO: commit config to etcd if changed and not empty"
      end
    end
  end
end