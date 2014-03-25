module Aedile
  class Unit
    UNIT_TEMPLATE = Tilt.new(File.dirname(__FILE__) + '/templates/unit.service.liquid')

    attr_reader :service
    attr_reader :index

    def initialize(client, service, index)
      @client  = client
      @service = service
      @index   = index
    end

    def unit_name
      "#{@service.name}.#{@index}.service"
    end

    def conflict_glob
      @service.conflict_glob
    end

    def description
      "aedile: #{unit_name}"
    end

    def fleet?
      @client.fleetctl.exists?(unit_name)
    end

    def unit_content
      UNIT_TEMPLATE.render(Object.new, {
        name:unit_name,
        conflict_glob: conflict_glob,
        description: description, 
        image: service.image, 
        command: service.command
      })
    end

    def status_hash
      {
        UNIT: unit_name,
        STATUS: "up",
      }
    end

    def start
      @client.fleetctl.start(unit_name)
    end

    def submit
      @client.fleetctl.submit(unit_name, unit_content)
    rescue FleetCtl::SubmitFailed => e
      raise unless e.message =~ /Key already exists/
    end

    def destroy
      @client.fleetctl.destroy(unit_name)
    end

    def sync
      # TODO: if exists, destroy and submit/start if changes
      # TODO: else submit/enable
      submit
      start
    end

    def fleet_status
      #TODO
    end
  end
end