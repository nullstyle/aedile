module Aedile
  module Cli
    class ProcessCommands < ::Thor
      include Aedile::Thor

      desc "list NAME", "show processes for service NAME (or all services if NAME is unspecified)"
      def list(service_name=nil)
        puts "TODO: load and show processes in a tree"
      end
    end
  end
end