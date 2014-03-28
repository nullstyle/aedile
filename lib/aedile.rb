require "aedile/version"
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/strip'
require 'active_support/core_ext/hash'
require 'active_support/inflector'
require 'etcd'
require 'multi_json'
require 'tilt'
require 'liquid'
require 'tilt/liquid'
require 'pry'

module Aedile
  extend ActiveSupport::Autoload 

  autoload :Cli
  autoload :EditJson
  autoload :Client
  autoload :FleetCtl
  autoload :DockerUtil

  # "model" objects
  autoload :Service
  autoload :ServiceConfig
  autoload :Unit


  class EtcdCannotBeContacted < StandardError ; end
  class FleetCannotBeContacted < StandardError ; end

end
