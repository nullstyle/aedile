module Aedile
  module Cli
    class SubmitUnit < UnitCommand

      def run
        unit.sync
        console.unit_submitted(unit)
      end
      
    end
  end
end