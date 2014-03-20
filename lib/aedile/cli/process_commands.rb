module Aedile
  module Cli
    class ProcessCommands < ::Thor
      include Aedile::Thor

      desc "list NAME", "show processes for service NAME (or all services if NAME is unspecified)"
      def list(service_name=nil)
        view Aedile.client.processes.map(&:status_hash), class: :tab_table, fields: [:UNIT, :STATUS]
      end
    end
  end
end