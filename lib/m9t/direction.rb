# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

module M9t

  class Direction
    DEFAULT_OPTIONS = {:units => :degrees, :abbreviated => true, :decimals => 0}
    CIRCLE = 360.0
    KNOWN_UNITS = [:degrees, :compass]
    SECTOR_DEGREES = CIRCLE / 16.0

    class << self
      @@options = DEFAULT_OPTIONS.clone
      def options
        @@options
      end

      def reset_options!
        @@options = DEFAULT_OPTIONS.clone
      end

      def to_degrees(d)
        d
      end

      def to_compass(d)
        sector = (normalize(d) / SECTOR_DEGREES).round
        I18n.t('direction.sectors')[sector]
      end

      def compass(s)
        sector = I18n.t('direction.sectors').find_index(s)
        raise "Compass direction '#{ s }' not recognised" if sector.nil?
        new(sector.to_f * SECTOR_DEGREES)
      end

      def normalize(d)
        case
        when d < 0
          normalize(d + CIRCLE)
        when d >= CIRCLE
          normalize(d - CIRCLE)
        else
          d
        end
      end
    end

    attr_reader :value, :options

    def initialize(value, options = Direction.options.clone)
      @value, @options = value.to_f, Direction.options.merge(options)
      raise M9t::UnitError.new("Unknown units '#{ @options[:units] }'") if not KNOWN_UNITS.find_index(@options[:units])
    end

    def to_s
      value_in_units = Direction.send("to_#{ @options[:units] }", @value)
      if @options[:units] == :compass
        Direction.to_compass(@value)
      else
        localized_value = I18n.localize_float(value_in_units, {:format => "%0.#{ @options[:decimals] }f"})
        key = 'units.direction.degrees'
        key += @options[:abbreviated] ? '.abbreviated' : '.full'
        unit = I18n.t(key, {:count => value_in_units})
        "#{ localized_value }%s#{ unit }" % (@options[:abbreviated] ? '' : ' ')
      end
    end

  end

end
