module Aedile
  module Cli
    class ServiceCommand < Base

      def name
        @args.first
      end

      def service
        @service = begin
          service = client.get_service(name)
          raise "Service #{name} doesn't exist" unless service.exists?
          service
        end
      end
      
    end
  end
end