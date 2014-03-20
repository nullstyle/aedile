module Aedile
  module Util
    def dump_json(obj)
      MultiJson.dump(obj, :pretty => true)
    end

    def load_json(json)
      MultiJson.load(json, :symbolize_keys => true)
    end

    extend self
  end
end