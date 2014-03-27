module Aedile
  module Cli
    class ScaleService < Base

      def run
        @args.each{ |s| scale_service(s) }
      end

      private
      def scale_service(arg)
        
        name, scale = arg.split("=", 2)
        scale       = Integer(scale)
        
        service = client.get_service(name)

        unless service.exists?
          puts "error: service #{name} doesn't exist"
          return
        end

        service.set_scale(scale)

        puts "scale for service #{name} set to #{scale}"
      end
      
    end
  end
end