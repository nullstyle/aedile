module Aedile
  class Service

    class AlreadyExists < StandardError; end
    class NotFound < StandardError; end
    class InvalidConfig < StandardError; end

    attr_reader :name

    DEFAULT_CONFIG_JSON = <<-JSON.strip_heredoc
    {
      "image":   "ubuntu",
      "command": "/bin/bash -c 'while true; do echo Hello World; sleep 1; done'"
    }
    JSON

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
      @config ||= ServiceConfig.new(@client.etcd.get(config_etcd_key).value)
    rescue Etcd::KeyNotFound => e
      @config = ServiceConfig.new(DEFAULT_CONFIG_JSON)
    end

    def set_config(config)
      @config = config
      raise InvalidConfig if config.hash[:image].blank?

      @client.etcd.set(config_etcd_key, value:config.json, prevExist:true)
    rescue Etcd::KeyNotFound
      raise NotFound
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

    def units
      @client.units(self)
    end

    def units_in_fleet
      @units_in_fleet = @client.fleetctl.units.select{|u| File.fnmatch(conflict_glob, u)}
    end

    def conflict_glob
      "#{name}.*.service"
    end

    def create(initial_config)
      @client.etcd.set(config_etcd_key, value:initial_config.json, prevExist:false)
    rescue Etcd::NodeExist
      raise AlreadyExists
    end

    def delete
      begin
        @client.etcd.delete(etcd_key, recursive:true)
      rescue Etcd::KeyNotFound
        raise NotFound
      end
    end

    def image
      config.hash[:image]
    end

    def command
      config.hash[:command]
    end

    def status_hash
      {
        SERVICE: name,
        STATUS: "3 instances running (5 desired)",
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