module Aedile
  module Cli
    class NewService < Base

      def run
        name    = @args.first
        service = client.get_service(name)

        raise Aedile::Service::AlreadyExists if service.exists?        

        result, new_config = *Util.edit_as_json(service.config)
        case result
        when :changed, :unchanged ; #noop, continue onto etcd write
        when :canceled ;
          raise "Creation canceled"
        when :unparsable ;
          # TODO: ask to re-edit config
          raise "Aborting"
        else ;
          raise "Unknown result: #{result}"
        end

        service.create(new_config)
        puts "Created service #{name}"

        # puts "TODO: ask for initial scale"
        # puts "TODO: set initial scale in etcd"
      rescue Aedile::Service::AlreadyExists
        raise "Service #{name} already exists"
      end
      
    end
  end
end