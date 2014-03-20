require "aedile/version"
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'etcd'
require 'multi_json'

module Aedile
  extend ActiveSupport::Autoload 

  autoload :Cli
  autoload :Client
  autoload :Service
  autoload :Util

  def self.client
    @client ||= Client.new
  end
end
