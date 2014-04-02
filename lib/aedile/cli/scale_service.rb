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
          console.service_not_found(name, false)
          return
        end

        service.set_scale(scale)

        console.service_scaled(service, scale)
      end
      
    end
  end
end