module Aedile
  module Cli
    class RootCommands < ::Thor
      include Aedile::Thor

      map "srv" => :service  
      
      desc "service SUBCOMMAND ...ARGS", "manage the set of services"
      subcommand "service", ServiceCommands


      desc "process SUBCOMMAND ...ARGS", "interact with individual aedile-managed processes"
      subcommand "process", ProcessCommands

      desc "status", "shows aedile's status"
      def status
        view Aedile.client.services.map(&:status_hash), class: :tab_table
      end

      desc "ps", "show processes"
      def ps
        invoke ProcessCommands, "list"
      end

      desc "manage", "starts running process that watches etcd for config changes and applies them"
      def manage
        puts "TODO: watch for service changes"
        puts "TODO: push service changes through to fleet"
      end
    end
  end
end