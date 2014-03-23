module Aedile
  module Cli
    class ListServices < Base

      def run
        client.service_names.each{|s| puts s }
      end
      
    end
  end
end