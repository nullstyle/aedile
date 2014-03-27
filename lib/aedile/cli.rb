module Aedile
  module Cli
    extend ActiveSupport::Autoload

    autoload :Base

    autoload :Console
    autoload :Status

    autoload :Manage
    autoload :InstallManager
    autoload :UninstallManager

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
    autoload :DestroyUnit



  end
end
