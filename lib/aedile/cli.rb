module Aedile
  module Cli
    extend ActiveSupport::Autoload

    autoload :Base

    autoload :Status

    autoload :Manage
    autoload :InstallManager

    autoload :ListServices

    autoload :ServiceCommand
    autoload :NewService
    autoload :ShowService
    autoload :EditService
    autoload :DeleteService
    autoload :ScaleService

    autoload :ListUnits

    autoload :UnitCommand
    autoload :ShowUnit
    autoload :SubmitUnit



  end
end