require "aedile/version"
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'active_support/inflector'
require 'etcd'
require 'multi_json'
require 'tilt'
require 'liquid'
require 'tilt/liquid'

module Aedile
  extend ActiveSupport::Autoload 

  autoload :Cli
  autoload :Util
  autoload :Client
  autoload :FleetCtl

  # "model" objects
  autoload :Service
  autoload :Process


  class EtcdCannotBeContacted < StandardError ; end
  class FleetCannotBeContacted < StandardError ; end

end
