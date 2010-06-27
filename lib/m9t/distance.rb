# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  # Represents a distance
  class Distance
    DEFAULT_OPTIONS      = {:units => :meters, :abbreviated => false, :precision => 5}
    CONVERSIONS          = {
      :meters     => 1.0,
      :kilometers => 1000.0,
      :feet       => 0.3048,
      :miles      => 1609.344
    }

    include M9t::Base

    alias :to_meters :value

  end

end
