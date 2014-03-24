module Aedile
  module Cli
    class SubmitUnit < UnitCommand

      def run
        unit.sync
        puts "#{unit_name} submitted to fleet"
      end
      
    end
  end
end