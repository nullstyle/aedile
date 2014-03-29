module Aedile
  module Cli
    class ListUnits < Base

      def run
        console.list_units(client.units)
      end
      
    end
  end
end