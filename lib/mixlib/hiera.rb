require 'hiera'
require 'mixlib/facter'

# rubocop:disable Style/Documentation
module Mixlib
  module Hiera
    include Mixlib::Facter

    def hiera_config(options = {})
      file = options[:config_file] || '/etc/hiera.yaml'
      (@hiera_config ||= {})[file] ||= YAML.load_file(file).freeze
      (options[:config_override] || {}).dup.update @hiera_config[file]
    end

    def hiera_instance(options = {})
      config = hiera_config options
      (@hiera_instance ||= {})[config.hash] ||= Hiera.new(config: config)
    end

    def hiera_lookup(key, options = {})
      hiera = hiera_instance config_file: options[:config_file]
                             config_override: options[:config_override]
      hiera.lookup key,
                   options[:default],
                   options[:scope] || facter.to_hiera_scope,
                   options[:order_override],
                   options[:resolution_type]
    end
  end
end
