module Aedile
  module Cli
    class RootCommands < ::Thor
      include Aedile::Thor

      class_option :endpoint, default: "http://172.17.42.1:4001"
      class_option :tunnel, type: :string

      map "srv" => :service  
      
      desc "service SUBCOMMAND ...ARGS", "manage the set of services"
      subcommand "service", ServiceCommands


      desc "process SUBCOMMAND ...ARGS", "interact with individual aedile-managed processes"
      subcommand "process", ProcessCommands

      desc "status", "shows aedile's status"
      def status
        view client.services.map(&:status_hash), class: :tab_table, fields: [:SERVICE, :STATUS]
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