module Aedile
  module EditJson

    class NoEditor  < StandardError; end
    class Unparsable  < StandardError; end
    class Canceled    < StandardError; end
    class Unchanged   < StandardError; end

    def dump_json(obj)
      MultiJson.dump(obj, :pretty => true)
    end

    def load_json(json)
      MultiJson.load(json, :symbolize_keys => true)
    end

    def edit_as_json(json, options={})
      options.reverse_merge!(error_on_unchanged: true)

      input  = json
      output = ""

      Tempfile.open([ 'aedile-edit-', '.json' ]) do |tf|
        tf.sync = true
        tf.puts input
        tf.close
        raise NoEditor, "Please set EDITOR environment variable" unless system("#{ENV["EDITOR"]} #{tf.path}")

        output = IO.read(tf.path).strip
      end

      raise Canceled  if output.blank?
      raise Unchanged if input == output && options[:error_on_unchanged]
      
      load_json(output) # sanity parse used to check for valid json
      output
    rescue MultiJson::ParseError
      if agree("Unparsable JSON, try again? (y/n)")
        retry
      else
        raise Unparsable
      end
      
    end

    extend self
  end
end