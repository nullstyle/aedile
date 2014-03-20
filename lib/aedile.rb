require "aedile/version"
require 'active_support'
require 'etcd'
require 'multi_json'

module Aedile
  extend ActiveSupport::Autoload 

  autoload :Cli
  autoload :Client
  autoload :Service

  def self.client
    @client ||= Client.new
  end
end
