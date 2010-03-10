# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

module M9t

  class Direction
    DEFAULT_OPTIONS = {:units => :degrees, :abbreviated => false, :decimals => 0}
    KNOWN_UNITS = [:degrees, :compass]
    CIRCLE = 360.0
    SECTOR_DEGREES = CIRCLE / 16.0

    include M9t::Base

    class << self

      def unit_name
        'direction'
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

    def to_s
      if @options[:units] == :compass
        Direction.to_compass(@value)
      else
        super
      end
    end

  end

end
