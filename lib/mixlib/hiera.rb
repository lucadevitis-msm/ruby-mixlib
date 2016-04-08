require 'hiera'
require 'mixlib/facter'

# rubocop:disable Style/Documentation
module Mixlib
  module Hiera
    include Mixlib::Facter

    def hiera_config(options = {})
      file = options[:config_file] || '/etc/hiera.yaml'
      override = options[:config_override] || {}
      @hiera_config ||= {}
      @hiera_config[file] ||= YAML.load_file(file).freeze
      override.update(@hiera_config[file])
    end

    def hiera_instance(options = {})
      config = hiera_config(options)
      @hiera_instance || = {}
      @hiera_instance[config.hash] ||= Hiera.new(config: config)
    end

    def hiera_lookup(key, options = {})
      hiera_instance.lookup key,
                            options[:default],
                            options[:scope] || facter.to_hiera_scope,
                            options[:order_override],
                            options[:resolution_type]
    end
  end
end
