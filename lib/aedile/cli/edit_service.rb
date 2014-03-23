module Aedile
  module Cli
    class EditService < ServiceCommand

      def run
        config  = service.config

        result, new_config = *Util.edit_as_json(config)

        case result
        when :changed ;
          set_result = service.set_config(new_config)

          case set_result
          when :updated ;         puts "Config for service #{name} updated"
          when :invalid_config ;  raise "Config for service #{name} would become invalid"
          else ;                  raise "Unknown result: #{set_result}"
          end

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
      
    end
  end
end