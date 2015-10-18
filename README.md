[![Build Status](https://secure.travis-ci.org/joeyates/m9t.png)][Continuous Integration]
[![Source Analysis](https://codeclimate.com/github/joeyates/m9t/badges/gpa.svg)](https://codeclimate.com/github/joeyates/m9t)
[![Test Coverage](https://codeclimate.com/github/joeyates/m9t/badges/coverage.svg)](https://codeclimate.com/github/joeyates/m9t/coverage)

# m9t

*Measurements and coversions library for Ruby*

  * [Source Code]
  * [API documentation]
  * [Rubygem]
  * [Continuous Integration]

[Source Code]: https://github.com/joeyates/m9t "Source code at GitHub"
[API documentation]: http://rubydoc.info/gems/m9t/frames "RDoc API Documentation at Rubydoc.info"
[Rubygem]: http://rubygems.org/gems/m9t "Ruby gem at rubygems.org"
[Continuous Integration]: http://travis-ci.org/joeyates/m9t "Build status by Travis-CI"

This package handles the basic units of measure:

- distance,
- direction,
- speed,
- temperature,
- weight.

The emphasis is on:

- coherent interface,
- ease of translation (using i18n).

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

```ruby
height = M9t::Distance.new(1.75)
```

to_f: returns the decimal value(s):

```ruby
height.to_f -> 1.75
```

other units:
there are class methods named after each known unit,
which take values in that unit
(actually, they are defined as needed):

```ruby
marathon = M9t::Distance.miles(26.21875)
marathon.to_f -> 42194.988
```

to_s: returns a localized string with units:

```ruby
I18n.locale = :it
puts M9t::Distance.new(3).to_s -> '3 metri'
```

Class methods for conversion
============================

Methods are available for conversion between any pair of units:

```ruby
M9t::Distance.miles_to_meters(26.21875) -> 42194.988
```

Alternatives
============

- ruby-units
  - Doesn't handle i18n:
    - The library depends heavily on English string representations of units.
  - Monkey patches a lot of core classes:
    - Adds methods to e.g. Object.

Contributors
============

* [Joe Yates](https://github.com/joeyates)
* [Florian Egermann and Mathias Wollin](https://github.com/math)

License
=======

Dual license:

- MIT License: see MIT-LICENSE.txt,
- GPL version 3: see GPL-LICENSE.txt
