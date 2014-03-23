module Aedile
  module Cli
    class ShowService < ServiceCommand

      def run
        puts EditJson.dump_json(service.config)
      end
      
    end
  end
end