require 'thor'

module Aedile
  module Cli
    extend ActiveSupport::Autoload 

    autoload :RootCommands
    autoload :ServiceCommands
    autoload :ProcessCommands
  end
end