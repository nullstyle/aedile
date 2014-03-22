require 'net/ssh/gateway'

module Aedile
  class FleetCtl
    BIN = 'fleetctl'
   
    def initialize(endpoint, tunnel)
      @endpoint = endpoint
      @tunnel   = tunnel
    end

    def submit(unit_name, unit_content)
      unit_file = "#{dir}/#{unit_name}"
      Dir.mktmpdir do |dir|
        IO.write(unit_file, unit_content)
        cmd = build_command("submit", unit_file)
        results =  `#{cmd}`
      end 
    end

    private
    def build_command(*args)
      command_options = args.extract_options!
      
      cmd = [BIN]
      global_args.each{|arg,value| cmd << %Q|--#{arg}="#{value}"|}
      args.each {|arg| cmd << arg}
      command_options.each{|arg,value| cmd << %Q|--#{arg}="#{value}"|}

      cmd.join(" ")
    end

    def global_args
      result = {endpoint: @endpoint.to_s}
      result[:tunnel] = "#{@tunnel.host}:#{@tunnel.port}" if @tunnel.present?
      result
    end
  end
end