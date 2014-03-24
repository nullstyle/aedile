module Aedile
  module Cli
    class DeleteService < ServiceCommand

      def run
        # TODO
        return if !agree("Are you sure you want to delete service #{name}? (y/n)")

        service.delete
        puts "Deleted service #{name}"
      rescue Service::NotFound ; 
        raise "Service #{name} doesn't exist"
      end
      
    end
  end
end