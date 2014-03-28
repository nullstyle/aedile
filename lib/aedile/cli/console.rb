module Aedile
  module Cli
    class Console < Base

      def run
        Pry.start client, prompt:[proc{ ">> " }, proc{ "|  " }]
      end
      
    end
  end
end