require "aedile/version"
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'etcd'
require 'multi_json'

module Aedile
  extend ActiveSupport::Autoload 

  autoload :Cli
  autoload :Thor
  autoload :Util
  autoload :Client
  autoload :FleetCtl

  # "model" objects
  autoload :Service
  autoload :Process


  class EtcdCannotBeContacted < StandardError ; end
  class FleetCannotBeContacted < StandardError ; end

end
