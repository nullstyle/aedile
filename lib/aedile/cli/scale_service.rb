module Aedile
  module Cli
    class ScaleService < ServiceCommand

      def run
        new_scale = Integer(@args[1])
        service.set_scale(new_scale)
        puts "scale for service #{name} set to #{new_scale}"
      end
      
    end
  end
end