module Aedile
  module Cli
    class EditService < ServiceCommand

      def run
        config  = service.config
        new_config = EditJson.edit_as_json(config)
        service.set_config(new_config)
        puts "Config for service #{name} updated"

      rescue Service::InvalidConfig
        raise "Config for service #{name} would become invalid"
      rescue EditJson::Unparsable
        raise "Edit aborted"
      rescue EditJson::Canceled
        raise "Edit canceled"
      rescue EditJson::Unchanged
        raise "Config for service #{name} unchanged"
      end
    end
  end
end