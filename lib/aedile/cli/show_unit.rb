module Aedile
  module Cli
    class ShowUnit < UnitCommand

      def run
        puts process.unit_content
      end
      
    end
  end
end