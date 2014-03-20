require 'thor'

module Aedile
  module Cli
    extend ActiveSupport::Autoload 

    autoload :Root
    autoload :Service
  end
end