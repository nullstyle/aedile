require 'hirb'

module Aedile
  module Thor
    extend ActiveSupport::Concern
    include Hirb::Console


    def die!(message)
      puts message
      exit 1
    end

    def win!(message=nil)
      puts message if message.present?
      exit 0
    end

    def client
      @client ||= Aedile::Client.new(options.slice(:endpoint, :tunnel))
    end
  end
end