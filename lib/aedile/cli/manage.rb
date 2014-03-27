module Aedile
  module Cli
    class Manage < Base

      def run
        boot_message

        loop do
          client.sync_with_fleet
          puts "=> Waiting for changes in config"
          client.etcd.watch("/aedile", recursive:true)
        end
      rescue Interrupt
        puts "Exiting..."
      end


      private
      def apply_changes
        puts "TODO: push service changes through to fleet"
      end

      def boot_message
        puts "=> Booting Aedile Manager - #{Aedile::VERSION}"
        puts "=> Performing Initial Sync..."
      end
    end

  end
end