module Aedile
  module Cli
    class NewService < Base

      def run
        name    = @args.first
        service = client.get_service(name)

        raise Service::AlreadyExists if service.exists?        

        new_config = EditJson.edit_as_json(service.config, error_on_unchanged: false)

        service.create(new_config)
        puts "Created service #{name}"

        # puts "TODO: ask for initial scale"
        # puts "TODO: set initial scale in etcd"
      rescue Service::AlreadyExists
        raise "Service #{name} already exists"
      rescue EditJson::Unparsable
        if agree("Unparsable JSON, try again? (y/n)")
          retry
        else
          raise "aborting"
        end
      rescue EditJson::Canceled
        raise "Creation canceled"
      end
      
    end
  end
end