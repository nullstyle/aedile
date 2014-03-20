module Aedile
  class Service
    attr_reader :name

    DEFAULT_CONFIG = {}

    def initialize(client, name)
      @client = client
      @name   = name
    end

    def config
      config_json = @client.etcd.get("/aedile/services/#{name}/config").value
      Util.load_json(config_json)
    rescue Etcd::KeyNotFound => e
      DEFAULT_CONFIG
    end

    def create(initial_config={})
      config_json = Util.dump_json(initial_config)

      begin
        @client.etcd.set("/aedile/services/#{name}/config", value:config_json, prevExist:false)
        :created
      rescue Etcd::NodeExist => e
        :already_exists
      end
    end

    def delete
      begin
        @client.etcd.delete("/aedile/services/#{name}", recursive:true)
        :deleted
      rescue Etcd::KeyNotFound => e
        :doesnt_exist
      end
    end
  end
end