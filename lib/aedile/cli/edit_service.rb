module Aedile
  module Cli
    class EditService < ServiceCommand

      def run
        new_config = ServiceConfig.from_edit(service.config)
        service.set_config(new_config)

        console.service_config_updated(service)

      rescue Service::InvalidConfig
        console.service_config_edit_failed(:invalid, service)
      rescue EditJson::Unparsable
        console.service_config_edit_failed(:aborted, service)
      rescue EditJson::Canceled
        console.service_config_edit_failed(:canceled, service)
      rescue EditJson::Unchanged
        console.service_config_edit_failed(:unchanged, service)
      end
    end
  end
end