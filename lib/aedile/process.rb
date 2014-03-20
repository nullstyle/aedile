require 'tilt'
require 'liquid'

module Aedile
  class Process
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

    def description
      "aedile: #{unit_name}"
    end

    def unit_content
      UNIT_TEMPLATE.render(
        name:unit_name,
        description: description, 
        image: service.image, 
        command: service.command
      )
    end

    def status_hash
      {
        UNIT: unit_name,
        STATUS: "up",
      }
    end

    def fleet_status
      #TODO
    end
  end
end