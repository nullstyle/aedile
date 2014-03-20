module Aedile
  class Service
    attr_reader :name

    DEFAULT_CONFIG = {
      image:   "ubuntu",
      command: "/bin/bash",
    }

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

    def set_config(config)
      #TODO: validate config

      config_json = Util.dump_json(config)
      @client.etcd.set("/aedile/services/#{name}/config", value:config_json, prevExist:true)
      :updated
    rescue Etcd::KeyNotFound => e
      :doesnt_exist
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