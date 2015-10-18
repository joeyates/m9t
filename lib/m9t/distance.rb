# encoding: utf-8
require 'm9t/base'

module M9t
  # Represents a distance
  class Distance
    DEFAULT_OPTIONS = {
      units: :meters, abbreviated: false, precision: 5
    }
    CONVERSIONS = {
      meters:     1.0,
      kilometers: 1.0 / 1000.0,
      feet:       1.0 / 0.3048,
      miles:      1.0 / 1609.344
    }

    include M9t::Base

    alias :to_meters :value
  end
end
