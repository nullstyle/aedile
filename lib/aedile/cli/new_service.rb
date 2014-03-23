module Aedile
  module Cli
    class NewService < Base

      def run
        name    = @args.first
        service = client.get_service(name)

        raise "Service #{name} already exists" if service.exists?        

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

        result = service.create(new_config)
        case result
        when :created ;         
          puts "Created service #{name}"
        when :already_exists ;  
          raise "Service #{name} already exists"
        else ;                  
          raise "Unknown result: #{result}"
        end


        # puts "TODO: ask for initial scale"
        # puts "TODO: set initial scale in etcd"
      end
      
    end
  end
end