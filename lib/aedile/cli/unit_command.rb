module Aedile
  module Cli
    class UnitCommand < Base

      def unit_name
        @args.first
      end

      def process
        @process = begin
          process = client.processes.find{|p| p.unit_name == unit_name}
          raise "Could not find process #{unit_name}" if process.blank?
          process
        end
      end
      
    end
  end
end