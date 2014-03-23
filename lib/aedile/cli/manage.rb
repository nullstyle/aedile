module Aedile
  module Cli
    class Manage < Base

      def run
        loop do
          puts "TODO: watch for service changes"
          puts "TODO: push service changes through to fleet"
          sleep 1
        end
      rescue Interrupt
        puts "Exiting..."
      end
    end

  end
end