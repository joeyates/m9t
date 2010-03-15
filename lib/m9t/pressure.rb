# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  # Represents atmospheric (or other) pressure
  class Pressure
    DEFAULT_OPTIONS  = {:units => :bar, :abbreviated => false, :precision => 5}
    KNOWN_UNITS      = [:bar, :pascals, :hectopascals, :kilopascals, :inches_of_mercury]

    # Conversions
    PASCAL          = 0.00001
    HECTOPASCAL     = 100.0 * PASCAL
    KILOPASCAL      = 1000.0 * PASCAL
    INCH_OF_MERCURY = 3386.389 * PASCAL

    include M9t::Base

    def Pressure.hectopascals(hectopascals)
      new(hectopascals * HECTOPASCAL)
    end

    def Pressure.inches_of_mercury(inches_of_mercury)
      new(inches_of_mercury * INCH_OF_MERCURY)
    end

    def Pressure.to_inches_of_mercury(bar)
      bar / INCH_OF_MERCURY
    end

    def Pressure.to_bar(bar)
      bar.to_f
    end

    def Pressure.parse(pressure)
      case
      when pressure =~ /^Q(\d{4})$/
        hectopascals($1.to_f)
      when pressure =~ /^A(\d{4})$/
        inches_of_mercury($1.to_f / 100.0)
      end
    end

    def to_inches_of_mercury
      Pressure.to_inches_of_mercury(@value)
    end

    def to_bar
      Pressure.to_bar(@value)
    end

  end

end
