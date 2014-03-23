module Aedile
  module Cli
    class DeleteService < ServiceCommand

      def run
        # TODO
        # win! if no?("Are you sure you want to delete service #{name}? (y/N)")

        result  = service.delete

        case result
        when :deleted ;       puts "Deleted service #{name}"
        when :doesnt_exist ;  raise "Service #{name} doesn't exist"
        else ;                raise "Unknown result: #{result}"
        end
      end
      
    end
  end
end