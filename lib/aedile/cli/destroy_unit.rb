module Aedile
  module Cli
    class DestroyUnit < Base

      def run
        unit_name = @args.first
        
        if unit_name == "*"
          client.units.map(&:destroy)
        else
          unit = client.units.find{|p| p.unit_name == unit_name}
          raise "Could not find unit #{unit_name}" if unit.blank?
          unit.destroy
        end
      end
      
    end
  end
end