# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  class Distance
    DEFAULT_OPTIONS = {:units => :meters, :abbreviated => false, :precision => 5}
    KNOWN_UNITS = [:meters, :miles, :kilometers]
    METERS_PER_MILE      = 1609.344
    METERS_PER_KILOMETER = 1000.0

    include M9t::Base

    class << self

      def unit_name
        'distance'
      end

      # Unit convertors: convert to meters
      def miles(m)
        m.to_f * METERS_PER_MILE
      end

      def kilometers(km)
        km.to_f * METERS_PER_KILOMETER
      end

      def to_meters(m)
        m.to_f
      end

      def to_kilometers(m)
        m.to_f / METERS_PER_KILOMETER
      end

      def to_miles(m)
        m.to_f / METERS_PER_MILE
      end

    end

    alias :to_meters :value

    def to_kilometers
      self.class.to_kilometers(@value)
    end

    def to_miles
      self.class.to_miles(@value)
    end

  end

end
