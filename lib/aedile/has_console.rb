module Aedile
  module HasConsole
    def console
      Aedile::Console.current
    end
  end
end