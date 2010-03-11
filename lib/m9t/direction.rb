# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

module M9t

  # Represents a geographical direction
  class Direction
    DEFAULT_OPTIONS = {:units => :degrees, :abbreviated => false, :decimals => 5}
    KNOWN_UNITS     = [:degrees, :compass]

    # Conversions
    CIRCLE                 = 360.0
    COMPASS_SECTOR_DEGREES = CIRCLE / 16.0

    include M9t::Base

    class << self

      # Identity conversion. Simply returns the supplied number
      def to_degrees(degrees)
        degrees.to_f
      end

      # Given a value in degrees, returns the nearest (localized) compass direction
      #  M9t::Directions.to_compass(42) => 'NE'
      def to_compass(degrees)
        sector = (normalize(degrees) / COMPASS_SECTOR_DEGREES).round
        I18n.t(self.measurement_name + '.sectors')[sector]
      end

      # Accepts a localized compass direction (e.g. 'N') and returns the equivalent M9t::Direction
      #  M9t::Direction.compass('NE') => #<M9t::Direction:0xb76cc750 @value=45.0, @options={:units=>:degrees, :decimals=>5, :abbreviated=>false}>
      def compass(compass_direction)
        sector = I18n.t(self.measurement_name + '.sectors').find_index(compass_direction)
        raise "Compass direction '#{ compass_direction }' not recognised" if sector.nil?
        new(sector.to_f * COMPASS_SECTOR_DEGREES)
      end

      # Reduce directions in degrees to the range [0, 360)
      #  M9t::Direction.normalize(1000) => 280.0
      def normalize(degrees)
        case
        when degrees < 0
          normalize(degrees + CIRCLE)
        when degrees >= CIRCLE
          normalize(degrees - CIRCLE)
        else
          degrees
        end
      end

    end

    # Handles the special case where compass directions are the desired output.
    def to_s
      if @options[:units] == :compass
        Direction.to_compass(@value)
      else
        super
      end
    end

  end

end
