module Aedile
  module Cli
    class NewService < Base

      def run
        name    = @args.first
        service = client.get_service(name)

        raise Service::AlreadyExists if service.exists?        

        new_config = ServiceConfig.from_edit(service.config, error_on_unchanged: false)

        service.create(new_config)
        console.service_created(service)

        # puts "TODO: ask for initial scale"
        # puts "TODO: set initial scale in etcd"
      rescue Service::AlreadyExists
        console.service_create_failed(:already_exists, service)
      rescue EditJson::Unparsable
        console.service_create_failed(:aborted, service)
      rescue EditJson::Canceled
        console.service_create_failed(:canceled, service)
      end
      
    end
  end
end