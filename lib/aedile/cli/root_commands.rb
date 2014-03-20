module Aedile
  module Cli
    class RootCommands < ::Thor
      include Aedile::Thor
      
      desc "service SUBCOMMAND ...ARGS", "manage the set of services"
      subcommand "service", ServiceCommands

      desc "status", "shows aedile's status"
      def status
        puts "TODO: show each service along with the services scale and actual running processes"
      end

      desc "manage", "starts running process that watches etcd for config changes and applies them"
      def manage
        puts "TODO: watch for service changes"
        puts "TODO: push service changes through to fleet"
      end
    end
  end
end