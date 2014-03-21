module Aedile
  class Client
    attr_reader :etcd
    
    def initialize(endpoint)
      uri = URI.parse(endpoint)
      raise URI::InvalidURIError unless uri.is_a?(URI::HTTP)

      @etcd = Etcd.client(host: uri.host, port: uri.port)

    rescue URI::InvalidURIError
      raise ArgumentError, "Invalid endpoint '#{endpoint}': please supply a valid http uri"
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
  end
end