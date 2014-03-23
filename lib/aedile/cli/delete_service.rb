module Aedile
  module Cli
    class DeleteService < ServiceCommand

      def run
        # TODO
        # win! if no?("Are you sure you want to delete service #{name}? (y/N)")

        service.delete
        puts "Deleted service #{name}"
      rescue Aedile::Service::NotFound ; 
        raise "Service #{name} doesn't exist"
      end
      
    end
  end
end