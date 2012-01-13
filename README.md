m9t - A Ruby Gem for Measurements
=================================

This package handles the basic units of measure:

- distance,
- direction,
- speed,
- temperature,
- weight.

The emphasis is on:

- coherent interface,
- ease of translation (using i18n).

[![Build Status](https://secure.travis-ci.org/joeyates/m9t.png)](http://travis-ci.org/joeyates/m9t)

Internals
=========

Internally, values are stored in SI units, with the exception of temperature:

- distance - meters,
- direction - degrees,
- speed - meters per second,
- temperature - degrees celcius,
- weight - kilograms.

Interface
=========

new: accepts the S.I. unit as a parameter:

    height = M9t::Distance.new(1.75)

to_f: returns the decimal value(s):

    height.to_f -> 1.75

other units:
there are class methods named after each known unit,
which take values in that unit
(actually, they are defined as needed):

    marathon = M9t::Distance.miles(26.21875)
    marathon.to_f -> 42194.988

to_s: returns a localized string with units:

    I18n.locale = :it
    puts M9t::Distance.new(3).to_s -> '3 metri'

Class methods for conversion
============================

Methods are available for conversion between any pair of units:

    M9t::Distance.miles_to_meters(26.21875) -> 42194.988

Testing
=======

Coverage
--------

ruby 1.8.x:

    $ rake rcov

ruby 1.9.x:

    $ COVERAGE=1 rake test

Alternatives
============

- ruby-units
  - Doesn't handle i18n:
    - The library depends heavily on English string representations of units.
  - Monkey patches a lot of core classes:
    - Adds methods to e.g. Object.

License
=======

Dual license:

- MIT License: see MIT-LICENSE.txt,
- GPL version 3: see GPL-LICENSE.txt
