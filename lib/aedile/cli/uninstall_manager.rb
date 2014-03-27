module Aedile
  module Cli
    class UninstallManager < Base

      def run
        client.uninstall_manager
        puts "Aedile manager removed from fleet"
      end

    end
  end
end
