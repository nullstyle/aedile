module Aedile
  module Cli
    class ShowService < ServiceCommand

      def run
        console.show_service service
      end
      
    end
  end
end