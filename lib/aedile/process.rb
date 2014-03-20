module Aedile
  class Process
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