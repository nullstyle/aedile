module Aedile
  module Cli
    class ListUnits < Base

      def run
        view client.processes.map(&:status_hash), class: :tab_table, fields: [:UNIT, :STATUS]
      end
      
    end
  end
end