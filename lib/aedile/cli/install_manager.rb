module Aedile
  module Cli
    class InstallManager < Base

      def run
        client.install_manager
        puts "Aedile manager installed into fleet"
      end

    end
  end
end