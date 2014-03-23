module Aedile
  module Cli
    class SubmitUnit < UnitCommand

      def run
        process.submit_unit
        puts "#{unit_name} submitted to fleet"
      end
      
    end
  end
end