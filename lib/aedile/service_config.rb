module Aedile
  class ServiceConfig

    attr_reader :json
    attr_reader :hash

    def self.from_edit(existing_config, edit_options={})
      new_json = EditJson.edit_as_json(existing_config.json, edit_options)
      new(new_json)
    end
    
    def initialize(json)
      @json = json
      @hash = MultiJson.load(json, :symbolize_keys => true)
    end

    def json=(value)
      @json = value
      @hash = MultiJson.load(json, :symbolize_keys => true)
    end


  end
end