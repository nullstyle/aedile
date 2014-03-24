module Aedile
  module Cli
    class Console < Base

      def run
        require 'pry'
        binding.pry
      end
      
    end
  end
end