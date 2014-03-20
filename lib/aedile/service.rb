module Aedile
  class Service
    attr_reader :name

    def initialize(client, name)
      @client = client
      @name   = name
    end

    def config
      @client.etcd.get
    end

    def create(initial_config={})
      config_json = MultiJson.dump(initial_config, :pretty => true)

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