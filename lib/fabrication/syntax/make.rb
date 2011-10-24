module Fabrication
  module Syntax

    # Extends Fabrication to provide make/make! class methods, which are
    # shortcuts for Fabricate.build/Fabricate.
    #
    # Usage:
    #
    # require 'fabrication/syntax/make'
    #
    # User.make(:name => 'Johnny')
    #
    #
    module Make
      def make(overrides = {}, &block)
        Fabricate.build(name.underscore.to_sym, overrides, &block)
      end

      def make!(overrides = {}, &block)
        Fabricate(name.underscore.to_sym, overrides, &block)
      end
    end
  end
end

if defined? Sequel
  Sequel::Model.extend Fabrication::Syntax::Make
end

if defined? ActiveRecord
  ActiveRecord::Base.extend Fabrication::Syntax::Make
end

if defined? Mongoid
  module Mongoid::Document
    def self.included(base)
      base.send :extend, Fabrication::Syntax::Make
    end
  end
end
