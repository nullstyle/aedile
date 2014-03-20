module Aedile
  module Thor
    def die!(message)
      puts message
      exit 1
    end

    def win!(message=nil)
      puts message if message.present?
      exit 0
    end
  end
end