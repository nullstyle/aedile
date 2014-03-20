module Aedile
  class Client
    attr_reader :etcd
    
    def initialize
      @etcd = Etcd.client
    end

    def services
      service_names.map{|name| get_service(name) }
    end

    def service_names
      services =  begin
                    @etcd.get("/aedile/services").children.map{|child| File.basename(child.key) }
                  rescue Etcd::KeyNotFound => e
                    []
                  end
    end

    def get_service(name)
      @services ||= {}
      @services[name] ||= Service.new(self, name)
    end
  end
end