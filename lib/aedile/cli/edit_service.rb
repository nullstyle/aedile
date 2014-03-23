module Aedile
  module Cli
    class EditService < ServiceCommand

      def run
        config  = service.config

        result, new_config = *Util.edit_as_json(config)

        case result
        when :changed ;
          service.set_config(new_config)
          puts "Config for service #{name} updated"
        when :canceled ;
          raise "Edit canceled"
        when :unchanged ;
          raise "Config for service #{name} unchanged"
        when :unparsable ;
          # TODO: ask and retry
          # edit(name) if yes?("Unparsable JSON, try again? (y/N)")
          raise "Unparseable JSON"
        else
          raise "Unknown result: #{result}"
        end
      end
    
    rescue Aedile::Service::InvalidConfig
      raise "Config for service #{name} would become invalid"
    end
  end
end