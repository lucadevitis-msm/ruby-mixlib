require 'hiera'
require 'facter'
require 'hiera/backend/eyaml/options'
require 'hiera/backend/eyaml/subcommand'

# rubocop:disable Style/Documentation
module Mixlib
  module Eyaml
    def eyaml(subcommand, options = {})
      Eyaml::Options.set options
      (Subcommand.find subcommand).execute
    end
  end
end
