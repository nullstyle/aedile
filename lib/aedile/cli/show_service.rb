module Aedile
  module Cli
    class ShowService < ServiceCommand

      def run
        puts service.config.json
      end
      
    end
  end
end