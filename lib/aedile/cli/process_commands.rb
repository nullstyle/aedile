module Aedile
  module Cli
    class ProcessCommands < ::Thor
      include Aedile::Thor

      desc "list NAME", "show processes for service NAME (or all services if NAME is unspecified)"
      def list(service_name=nil)
        view client.processes.map(&:status_hash), class: :tab_table, fields: [:UNIT, :STATUS]
      end

      desc "show UNIT_NAME", "show rendered unit content for UNIT_NAME"
      def show(unit_name)
        process = client.processes.find{|p| p.unit_name == unit_name}
        die! "Could not find process #{unit_name}: aborting" if process.blank?

        puts process.unit_content
      end
    end
  end
end