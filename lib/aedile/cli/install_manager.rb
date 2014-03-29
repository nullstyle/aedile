module Aedile
  module Cli
    class InstallManager < Base

      def run
        client.install_manager
        console.manager_installed
      end

    end
  end
end