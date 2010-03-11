# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'distance')

module M9t

  class Speed
    DEFAULT_OPTIONS = {:units => :meters_per_second, :abbreviated => false, :precision => 5}
    KNOWN_UNITS     = [:meters_per_second, :kilometers_per_hour, :miles_per_hour, :knots]

    # Conversions
    SECONDS_PER_HOUR  = 60.0 * 60
    MS_TO_KMH         = SECONDS_PER_HOUR / M9t::Distance::METERS_PER_KILOMETER
    MS_TO_MPH         = SECONDS_PER_HOUR / M9t::Distance::METERS_PER_MILE

    include M9t::Base

    class << self

      # Unit convertors: convert to meters per second
      def kilometers_per_hour(kmh)
        kmh.to_f * MS_TO_KMH
      end

      def miles_per_hour(mph)
        mph.to_f * MS_TO_MPH
      end

      def to_meters_per_second(mps)
        mps.to_f
      end

      def to_kilometers_per_hour(mps)
        mps.to_f / MS_TO_KMH
      end

      def to_miles_per_hour(mps)
        mps.to_f / MS_TO_MPH
      end

    end

    alias :to_meters_per_second :value

    def to_kilometers_per_hour
      self.class.to_kilometers_per_hour(@value)
    end

    def to_miles_per_hour
      self.class.to_miles_per_hour(@value)
    end

  end

end
