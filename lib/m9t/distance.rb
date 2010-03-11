# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  class Distance
    DEFAULT_OPTIONS      = {:units => :meters, :abbreviated => false, :precision => 5}
    KNOWN_UNITS          = [:meters, :miles, :kilometers]

    # Conversions
    METERS_PER_MILE      = 1609.344
    METERS_PER_KILOMETER = 1000.0

    include M9t::Base

    class << self

      # Converts kilometers into meters
      def kilometers(km)
        km.to_f * METERS_PER_KILOMETER
      end

      # Converts miles into meters
      def miles(m)
        m.to_f * METERS_PER_MILE
      end

      # Identity conversion. Simply returns the supplied number
      def to_meters(m)
        m.to_f
      end

      # Converts meters into kilometers
      def to_kilometers(m)
        m.to_f / METERS_PER_KILOMETER
      end

      # Converts meters into miles
      def to_miles(m)
        m.to_f / METERS_PER_MILE
      end

    end

    alias :to_meters :value

    # Returns the value converted to kilometers
    def to_kilometers
      self.class.to_kilometers(@value)
    end

    # Returns the value converted to miles
    def to_miles
      self.class.to_miles(@value)
    end

  end

end
