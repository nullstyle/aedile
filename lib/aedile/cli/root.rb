module Aedile
  module Cli
    class Root < Thor

      desc "service SUBCOMMAND ...ARGS", "manage the set of services"
      subcommand "service", Service

      desc "status", "shows aedile's status"
      def status
        puts "TODO: show each service along with the services scale and actual running processes"
      end

      desc "run", "starts running process that watches etcd for config changes and applies them"
      def run
        puts "TODO: watch for service changes"
        puts "TODO: push service changes through to fleet"
      end
    end
  end
end