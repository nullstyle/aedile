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

    def exists?
      @client.etcd.get(config_etcd_key)
      true
    rescue Etcd::KeyNotFound
      false
    end

    def config
      config_json = @client.etcd.get(config_etcd_key).value
      Util.load_json(config_json)
    rescue Etcd::KeyNotFound => e
      DEFAULT_CONFIG
    end

    def set_config(config)
      return :invalid_config if config[:image].blank?

      config_json = Util.dump_json(config)
      @client.etcd.set(config_etcd_key, value:config_json, prevExist:true)
      :updated
    rescue Etcd::KeyNotFound
      :doesnt_exist
    end

    def scale
      @client.etcd.get(scale_etcd_key).value.to_i
    rescue Etcd::KeyNotFound
      0
    end

    def set_scale(new_scale)
      raise ArgumentError, "Invalid scale:#{new_scale.inspect}" unless scale >= 0
      @client.etcd.set(scale_etcd_key, value:new_scale)
    end

    def create(initial_config={})
      config_json = Util.dump_json(initial_config)

      begin
        @client.etcd.set(config_etcd_key, value:config_json, prevExist:false)
        :created
      rescue Etcd::NodeExist
        :already_exists
      end
    end

    def delete
      begin
        @client.etcd.delete(etcd_key, recursive:true)
        :deleted
      rescue Etcd::KeyNotFound
        :doesnt_exist
      end
    end


    def status_hash
      {
        service: name,
        status: "3 processes running (5 desired)",
      }
    end

    private
    def etcd_key(subkey=nil)
      result = "/aedile/services/#{@name}"
      result << "/#{subkey}" if subkey.present?
      result
    end

    def config_etcd_key
      etcd_key("config")
    end

    def scale_etcd_key
      etcd_key("scale")
    end
  end
end