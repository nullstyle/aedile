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

        case service.create({})
        when :created ;
          puts "Created service #{name}"
        when :already_exists ;
          puts "Service #{name} already exists"
          exit 1
        end
      end

      desc "delete NAME", "deletes service NAME"
      def delete(name)
        puts "TODO: confirm deletion"
        puts "TODO: delete service"
      end

      desc "show NAME", "outputs the config for NAME to standard out"
      def show(name)
        puts "TODO: load config from etcd"
        puts "TODO: puts it to console"
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