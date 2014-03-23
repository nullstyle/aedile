module Aedile
  module Cli
    class ShowService < ServiceCommand

      def run
        puts Util.dump_json(service.config)
      end
      
    end
  end
end