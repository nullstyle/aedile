module Aedile
  module Util
    def dump_json(obj)
      MultiJson.dump(obj, :pretty => true)
    end

    def load_json(json)
      MultiJson.load(json, :symbolize_keys => true)
    end

    def edit_as_json(data)
      input  = dump_json(data).strip
      output = ""

      Tempfile.open([ 'aedile-edit-', '.json' ]) do |tf|
        tf.sync = true
        tf.puts input
        tf.close
        raise "Please set EDITOR environment variable" unless system("#{ENV["EDITOR"]} #{tf.path}")

        output = IO.read(tf.path).strip
      end

      return [:canceled, data]  if output.blank?
      return [:unchanged, data] if input == output
      
      [:changed, load_json(output)]
    end

    extend self
  end
end