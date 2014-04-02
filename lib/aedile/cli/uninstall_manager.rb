module Aedile
  module Cli
    class UninstallManager < Base

      def run
        client.uninstall_manager
        console.manager_uninstalled
      end

    end
  end
end
