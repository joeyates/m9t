# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'distance')

module M9t

  # Represents a speed
  class Speed
    DEFAULT_OPTIONS = {:units => :meters_per_second, :abbreviated => false, :precision => 5}
    SECONDS_PER_HOUR  = 60.0 * 60
    KMH               = M9t::Distance::CONVERSIONS[:kilometers] / SECONDS_PER_HOUR
    MPH               = M9t::Distance::CONVERSIONS[:miles] / SECONDS_PER_HOUR
    KNOTS_TO_KMH      = 1.852
    KNOTS             = KNOTS_TO_KMH / SECONDS_PER_HOUR * M9t::Distance::CONVERSIONS[:kilometers]
    CONVERSIONS = {
      :meters_per_second   => 1.0,
      :kilometers_per_hour => KMH,
      :miles_per_hour      => MPH,
      :knots               => KNOTS
    }

    include M9t::Base

    alias :to_meters_per_second :value

  end

end
