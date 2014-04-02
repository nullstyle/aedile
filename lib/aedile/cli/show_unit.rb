module Aedile
  module Cli
    class ShowUnit < UnitCommand

      def run
        console.show_unit unit
      end
      
    end
  end
end