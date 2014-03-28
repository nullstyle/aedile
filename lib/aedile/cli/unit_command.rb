module Aedile
  module Cli
    class UnitCommand < Base

      def unit_name
        @args.first
      end

      def unit
        @unit ||= begin
                    unit = client.units.find{|p| p.unit_name == unit_name}
                    console.unit_not_found(unit_name) if unit.blank?
                    unit
                  end
      end
      
    end
  end
end