module Aedile
  module Cli
    class Manage < Base

      def run
        loop do
          client.sync_with_fleet
          client.etcd.watch("/aedile", recursive:true)
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