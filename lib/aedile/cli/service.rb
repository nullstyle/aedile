module Aedile
  module Cli
    class Service < Thor

      desc "list", "shows all known services"
      def list
        etcd = Etcd.client
        services =  begin
                      etcd.get("/aedile/services")
                    rescue Etcd::KeyNotFound => e
                      []
                    end
                    
        services.each{|s| puts s }
      end

      desc "new NAME", "creates a new service named NAME"
      def new(name)
        puts "TODO: open an editor to set the beginning config"
        puts "TODO: commit config to etcd"
        puts "TODO: ask for initial scale"
        puts "TODO: set initial scale in etcd"
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