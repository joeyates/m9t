# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'distance')

module M9t

  class Speed
    DEFAULT_OPTIONS = {:units => :meters_per_second, :abbreviated => false, :precision => 5}
    KNOWN_UNITS = [:meters_per_second, :kilometers_per_hour, :miles_per_hour, :knots]
    SECONDS_PER_HOUR = 60.0 * 60
    METERS_PER_SECOND_PER_KILOMETER_PER_HOUR = SECONDS_PER_HOUR / M9t::Distance::METERS_PER_KILOMETER
    METERS_PER_SECOND_PER_MILE_PER_HOUR = SECONDS_PER_HOUR / M9t::Distance::METERS_PER_MILE

    class << self
      @@options = DEFAULT_OPTIONS.clone
      def options
        @@options
      end

      def reset_options!
        @@options = DEFAULT_OPTIONS.clone
      end

      # Unit convertors: convert to meters per second
      def kilometers_per_hour(kmh)
        kmh.to_f * METERS_PER_SECOND_PER_KILOMETER_PER_HOUR
      end

      def miles_per_hour(mph)
        mph.to_f * METERS_PER_SECOND_PER_MILE_PER_HOUR
      end

      def to_meters_per_second(mps)
        mps.to_f
      end

      def to_kilometers_per_hour(mps)
        mps.to_f / METERS_PER_SECOND_PER_KILOMETER_PER_HOUR
      end

      def to_miles_per_hour(mps)
        mps.to_f / METERS_PER_SECOND_PER_MILE_PER_HOUR
      end

    end

    attr_reader :value, :options
    alias :to_meters_per_second :value

    def initialize(value, options = Speed.options.clone)
      @value, @options = value.to_f, Speed.options.merge(options)
      raise M9t::UnitError.new("Unknown units '#{ @options[:units] }'") if not KNOWN_UNITS.find_index(@options[:units])
    end

    def to_s
      value_in_units = Speed.send("to_#{ @options[:units] }", @value)
      localized_value = I18n.localize_float(value_in_units, {:format => "%0.#{ @options[:precision] }f"})

      key = 'units.speed.' + @options[:units].to_s
      @options[:abbreviated] ? key += '.abbreviated' : key += '.full'
      unit = I18n.t(key, {:count => value_in_units})

      "#{ localized_value }%s#{ unit }" % (@options[:abbreviated] ? '' : ' ')
    end

    def to_kilometers_per_hour
      self.class.to_kilometers_per_hour(@value)
    end

    def to_miles_per_hour
      self.class.to_miles_per_hour(@value)
    end

  end

end
