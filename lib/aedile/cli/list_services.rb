module Aedile
  module Cli
    class ListServices < Base

      def run
        console.list_services(client.service_names)
      end
      
    end
  end
end