require 'hiera'
require 'facter'
require 'hiera/backend/eyaml/options'
require 'hiera/backend/eyaml/subcommand'

# rubocop:disable Style/Documentation
module Mixlib
  module Eyaml
    # @param [Symbol, String] subcommand  Any eyaml supported subcommand
    # @param [Hash]           options     Subcommand specific options
    #
    # @example encrypt, decrypt and recrypt
    #   private = '/etc/puppet/secure/keys/private_key.pkcs7.pem'
    #   public = '/etc/puppet/secure/keys/public_key.pkcs7.pem'
    #
    #   encrypted = eyaml :encrypt,
    #                     encrypt_method: 'pkcs7', # (default)
    #                     verbose: true,
    #                     string: 'my_secret_password',
    #                     pkcs7_private_key: private,
    #                     pkcs7_public_key: public
    #
    #   decrypted = eyaml :decrypt,
    #                     quiet: true,
    #                     file: '/path/to/file',
    #                     pkcs7_private_key: private,
    #                     pkcs7_public_key: public
    #
    #   eyaml :recrypt,
    #         trace: true,
    #         eyaml: '/path/to/file.eyaml',
    #         pkcs7_private_key: private,
    #         pkcs7_public_key: public

    def eyaml(subcommand, options = nil)
      Eyaml::Options.set options if options
      (Subcommand.find subcommand).execute
    end
  end
end
