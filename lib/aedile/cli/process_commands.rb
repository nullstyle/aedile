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
        process = load_process_by_unit_name(unit_name)
        puts process.unit_content
      end

      desc "submit UNIT_NAME", "submits the unit file for UNIT_NAME to fleet"
      def submit(unit_name)
        process = load_process_by_unit_name(unit_name)
        process.submit_unit
        win! "#{unit_name} submitted to fleet"
      end

      private
      def load_process_by_unit_name(unit_name)
        process = client.processes.find{|p| p.unit_name == unit_name}
        die! "Could not find process #{unit_name}: aborting" if process.blank?
        process
      end
    end
  end
end