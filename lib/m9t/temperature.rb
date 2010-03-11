# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  # Represents a temperature
  # Using degrees (celcius), not kelvin, as default unit
  class Temperature
    DEFAULT_OPTIONS      = {:units => :degrees, :abbreviated => false, :precision => 5}
    KNOWN_UNITS          = [:degrees, :kelvin, :fahrenheit]

    # Conversions
    ABSOLUTE_ZERO = -273.15

    include M9t::Base

    class << self

      # Alias for new
      def degrees(*args)
        new(*args)
      end

      # Accepts a value in kelvin and returns the equivalent M9t::Temperature
      def kelvin(kelvin, options = {})
        new(kelvin.to_f + ABSOLUTE_ZERO, options)
      end

      def fahrenheit(fahrenheit, options = {})
        new(fahrenheit_to_degrees(fahrenheit), options)
      end

      # Identity conversion. Simply returns the supplied number
      def to_degrees(degrees)
        degrees.to_f
      end

      # Converts degrees to kelvin
      def to_kelvin(degrees)
        degrees.to_f - ABSOLUTE_ZERO
      end

      # Converts degrees to Fahrenheit
      def to_fahrenheit(degrees)
        degrees.to_f * 9.0 / 5.0 + 32
      end

      # Converts kelvin to degrees
      def kelvin_to_degrees(kelvin)
        kelvin.to_f + ABSOLUTE_ZERO
      end

      # Converts Fahrenheit to degrees
      def fahrenheit_to_degrees(fahrenheit)
        fahrenheit.to_f - 32 * 5.0 / 9.0
      end

    end

    alias :to_degrees :value

    # Returns the value converted to kilometers
    def to_kelvin
      self.class.to_kelvin(@value)
    end

    def to_fahrenheit
      self.class.to_fahrenheit(@value)
    end

  end

end
