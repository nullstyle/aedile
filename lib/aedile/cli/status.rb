module Aedile
  module Cli
    class Status < Base

      def run
        view client.services.map(&:status_hash), class: :tab_table, fields: [:SERVICE, :STATUS]
      end
      
    end
  end
end