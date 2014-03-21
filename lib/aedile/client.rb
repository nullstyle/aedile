require 'net/ssh/gateway'

module Aedile
  class Client
    attr_reader :etcd
    attr_reader :fleetctl


    def initialize(options={})
      @options = options
      setup_endpoint
      setup_gateway

      endpoint_to_use = @tunnel_endpoint || @endpoint

      @etcd  = Etcd.client(host: endpoint_to_use.host, port: endpoint_to_use.port)
      @fleetctl = FleetCtl.new(@endpoint, @tunnel)

      test_etcd_connection
    end

    def services
      service_names.map{|name| get_service(name) }
    end

    def processes(service=nil)
      services = service.present? ? [service] : self.services

      services.each_with_object([]) do |service, result|
        service.scale.times do |i|
          result << get_process(service, i)
        end
      end
    end

    def service_names
      @service_names ||=  begin
                            @etcd.get("/aedile/services").children.map{|child| File.basename(child.key) }
                          rescue Etcd::KeyNotFound => e
                            []
                          end
    end

    def get_service(name)
      return name if name.is_a? Service
      @services ||= {}
      @services[name] ||= Service.new(self, name)
    end

    def get_process(service, index)
      @processes ||= {}
      @processes[service] ||= {}
      @processes[service][index] ||= Process.new(self, service, index)
    end

    private
    def setup_endpoint
      @endpoint = URI(@options[:endpoint])
      raise URI::InvalidURIError unless @endpoint.is_a?(URI::HTTP)
    rescue URI::InvalidURIError
      raise ArgumentError, "Invalid endpoint '#{@options[:endpoint]}': please supply a valid http uri"
    end

    def setup_gateway
      return if @options[:tunnel].blank?

      @tunnel = URI("ssh://#{@options[:tunnel]}")
      @tunnel.port ||= 22
      @tunnel.user ||= "core"

      gateway = Net::SSH::Gateway.new(@tunnel.host, @tunnel.user, :port => @tunnel.port)
      port = gateway.open('127.0.0.1', @endpoint.port)

      @tunnel_endpoint = URI("http://127.0.0.1:#{port}")
    end

    def test_etcd_connection
      @etcd.get("/")
    rescue Errno::ECONNREFUSED
      raise EtcdCannotBeContacted, "Cannot contact etcd at #{@endpoint}"
    end

  end
end