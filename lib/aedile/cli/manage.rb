module Aedile
  module Cli
    class Manage < Base

      def run
        boot_message

        loop do
          client.sync_with_fleet
          console.manager_waiting_for_changes
          client.etcd.watch("/aedile", recursive:true)
        end
      rescue Interrupt
        puts "Exiting..."
      end


      private
      def boot_message
        console.manager_booted
      end
    end

  end
end