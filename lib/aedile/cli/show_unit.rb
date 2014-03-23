module Aedile
  module Cli
    class ShowUnit < UnitCommand

      def run
        puts unit.unit_content
      end
      
    end
  end
end