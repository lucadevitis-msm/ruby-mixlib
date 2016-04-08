require 'facter'

module Mixlib
  module Facter
    def facter
      @facter ||= Facter.to_hash.freeze
    end
  end
end
class Hash
  def to_hiera_scope
    self.map {|fact, value| ["::#{fact}", value]}.to_h
  end
end
