# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  # Represents a distance
  class Distance
    DEFAULT_OPTIONS      = {:units => :meters, :abbreviated => false, :precision => 5}
    KNOWN_UNITS          = [:meters, :kilometers, :feet, :miles]

    # Conversions
    KILOMETER = 1000.0
    MILE      = 1609.344
    FOOT      = 0.3048

    include M9t::Base

    class << self

      # Alias for new
      def meters(*args)
        new(*args)
      end

      # Accepts a value in kilometers and returns the equivalent M9t::Distance
      def kilometers(km, options = {})
        new(km.to_f * KILOMETER, options)
      end

      # Accepts a value in miles and returns the equivalent M9t::Distance
      def miles(miles, options = {})
        new(miles.to_f * MILE, options)
      end

      # Accepts a value in miles and returns the equivalent M9t::Distance
      def feet(feet, options = {})
        new(feet.to_f * FOOT, options)
      end

      # Identity conversion. Simply returns the supplied number
      def to_meters(meters)
        meters.to_f
      end

      # Converts meters into kilometers
      def to_kilometers(meters)
        meters.to_f / KILOMETER
      end

      # Converts meters into miles
      def to_miles(meters)
        meters.to_f / MILE
      end

      # Converts meters into miles
      def to_feet(meters)
        meters.to_f / FOOT
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

    # Returns the value converted to feet
    def to_feet
      self.class.to_feet(@value)
    end

  end

end
