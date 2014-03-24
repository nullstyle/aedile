require 'hirb'
require 'highline/import'
require 'tempfile'

module Aedile
  module Cli
    class Base
      include Hirb::Console

      def initialize(global_options, command_options, args)
        @global_options  = global_options
        @command_options = command_options
        @args            = args

      end

      def run
        # raise NotImplementedError
        puts "Command: #{self.class}"
        puts "GOPTS: #{@global_options.inspect}"
        puts "COPTS: #{@command_options.inspect}"
        puts "ARGS: #{@args.inspect}"
      end

      private
      def client
        @client ||= Aedile::Client.new(@global_options.slice(:endpoint, :tunnel))
      end
    end
  end
end