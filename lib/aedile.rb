require "aedile/version"
require 'active_support'
require 'etcd'

module Aedile
  extend ActiveSupport::Autoload 

  autoload :Cli
end
