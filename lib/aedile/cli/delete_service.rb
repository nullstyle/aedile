module Aedile
  module Cli
    class DeleteService < ServiceCommand

      def run
        return unless console.confirm_service_delete(service)
        service.delete
        console.service_deleted(service)
      end
      
    end
  end
end