# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  # Represents a distance
  class Distance
    DEFAULT_OPTIONS      = {:units => :meters, :abbreviated => false, :precision => 5}
    KNOWN_UNITS          = [:meters, :miles, :kilometers]

    # Conversions
    METERS_PER_MILE      = 1609.344
    METERS_PER_KILOMETER = 1000.0

    include M9t::Base

    class << self

      # Alias for new
      def meters(*args)
        new(*args)
      end

      # Accepts a value in kilometers and returns the equivalent M9t::Distance
      def kilometers(km, options = {})
        new(km.to_f * METERS_PER_KILOMETER, options)
      end

      # Accepts a value in miles and returns the equivalent M9t::Distance
      def miles(miles, options = {})
        new(miles.to_f * METERS_PER_MILE, options)
      end

      # Identity conversion. Simply returns the supplied number
      def to_meters(meters)
        meters.to_f
      end

      # Converts meters into kilometers
      def to_kilometers(meters)
        meters.to_f / METERS_PER_KILOMETER
      end

      # Converts meters into miles
      def to_miles(meters)
        meters.to_f / METERS_PER_MILE
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
