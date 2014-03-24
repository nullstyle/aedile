module Aedile
  module Cli
    class Manage < Base

      def run
        loop do
          client.etcd.watch("/aedile", recursive:true)
          client.sync_with_fleet
        end
      rescue Interrupt
        puts "Exiting..."
      end


      private
      def apply_changes
        puts "TODO: push service changes through to fleet"
      end
    end

  end
end