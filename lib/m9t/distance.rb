# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

module M9t

  class Distance
    KNOWN_UNITS = [:meters, :miles, :kilometers]
    METERS_PER_MILE      = 1609.344
    METERS_PER_KILOMETER = 1000.0

    class << self
      # Default output options
      @@options = {:units => :meters, :abbreviated => false, :precision => 5}
      def options
        @@options
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

    attr_reader :value, :options
    alias :to_meters :value

    def initialize(value, options = Distance.options.clone)
      @value, @options = value.to_f, Distance.options.merge(options)
      raise "Unknown units '#{ @options[:units] }'" if not KNOWN_UNITS.find_index(@options[:units])
    end

    def to_s
      value_in_units = Distance.send("to_#{ @options[:units] }", @value)
      localized_value = I18n.localize_float(value_in_units, {:format => "%0.#{ @options[:precision] }f"})

      key = 'units.distance.' + @options[:units].to_s
      @options[:abbreviated] ? key += '.abbreviated' : key += '.full'
      unit = I18n.t(key, {:count => value_in_units})

      "#{ localized_value }%s#{ unit }" % (@options[:abbreviated] ? '' : ' ')
    end

    def to_kilometers
      self.class.to_kilometers(@value)
    end

    def to_miles
      self.to_miles(@value)
    end

  end

end
