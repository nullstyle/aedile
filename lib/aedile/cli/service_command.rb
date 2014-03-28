module Aedile
  module Cli
    class ServiceCommand < Base

      def name
        @args.first
      end

      def service
        @service ||=  begin
                        service = client.get_service(name)
                        console.service_not_found(name) unless service.exists?
                        service
                      end
      end
      
    end
  end
end