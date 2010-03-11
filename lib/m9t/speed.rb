# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'distance')

module M9t

  # Represents a speed
  class Speed
    DEFAULT_OPTIONS = {:units => :meters_per_second, :abbreviated => false, :precision => 5}
    KNOWN_UNITS     = [:meters_per_second, :kilometers_per_hour, :miles_per_hour, :knots]

    # Conversions
    SECONDS_PER_HOUR  = 60.0 * 60
    MS_TO_KMH         = SECONDS_PER_HOUR / M9t::Distance::METERS_PER_KILOMETER
    MS_TO_MPH         = SECONDS_PER_HOUR / M9t::Distance::METERS_PER_MILE
    KNOTS_TO_KMH      = 1.852
    MS_TO_KNOTS       = 1.0 / (KNOTS_TO_KMH / SECONDS_PER_HOUR * M9t::Distance::METERS_PER_KILOMETER)

    include M9t::Base

    class << self

      # Accepts kilometers per hour and returns a M9t::Speed instance
      def kilometers_per_hour(kmh, options = {})
        new(kmh.to_f / MS_TO_KMH, options)
      end

      # Accepts miles per hour and returns a M9t::Speed instance
      def miles_per_hour(mph, options = {})
        new(mph.to_f / MS_TO_MPH, options)
      end

      # Accepts knots and returns a M9t::Speed instance
      def knots(knots, options = {})
        new(knots.to_f / MS_TO_KNOTS, options)
      end

      # Alias for new
      def meters_per_second(*args)
        new(*args)
      end

      # Identity conversion. Simply returns the supplied number
      def to_meters_per_second(mps)
        mps.to_f
      end

      # Converts meters per second to kilometers per hour
      def to_kilometers_per_hour(mps)
        mps.to_f * MS_TO_KMH
      end

      # Converts meters per second to miles per hour
      def to_miles_per_hour(mps)
        mps.to_f * MS_TO_MPH
      end

      # Converts meters per second to knots
      def to_knots(mps)
        mps.to_f * MS_TO_KNOTS
      end

      # Converts knots to kilometers hour
      def knots_to_kilometers_per_hour(knots)
        to_kilometers_per_hour(knots.to_f / MS_TO_KNOTS)
      end

      # Converts knots to kilometers hour
      def kilometers_per_hour_to_knots(knh)
        to_knots(kmh.to_f / MS_TO_KMH)
      end

    end

    alias :to_meters_per_second :value

    # Returns the value converted to kilometers per hour
    def to_kilometers_per_hour
      self.class.to_kilometers_per_hour(@value)
    end

    # Returns the value converted to miles per hour
    def to_miles_per_hour
      self.class.to_miles_per_hour(@value)
    end

  end

end
