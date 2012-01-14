# encoding: utf-8

require File.expand_path( 'test_helper', File.dirname( __FILE__ ) )

class TestM9tSpeed < Test::Unit::TestCase

  def setup
    I18n.locale = :en
    M9t::Speed.reset_options!
  end

  # Basic use
  def test_new
    assert_equal(45, M9t::Speed.new(45).value)
  end

  # Class methods

  # Base class

  def test_measurement_name
    assert_equal('speed', M9t::Speed.measurement_name)
  end

  # conversion constants

  def test_knot_conversion
    assert_in_delta(1.9438, M9t::Speed::KNOTS, 0.0001)
  end

  # input conversions

  def test_class_kilometers_per_hour
    assert_in_delta(0.2778, M9t::Speed.kilometers_per_hour(1).value, 0.0001)
  end

  def test_class_miles_per_hour
    assert_in_delta(0.447, M9t::Speed.miles_per_hour(1).value, 0.0001)
  end

  def test_class_knots
    assert_in_delta 0.5144, M9t::Speed.knots(1).value, 0.0001
  end

  # output conversions

  def test_class_to_miles_per_hour
    assert_in_delta(100.6621, M9t::Speed.meters_per_second_to_miles_per_hour(45), 0.0001)
  end

  # Instance methods

  # new

  def test_unknown_units
    speed = M9t::Speed.new( '010' )

    assert_raises( M9t::UnitError ) do
      speed.to_s( :units => :foos )
    end
  end

  # output conversions

  def test_kmh
    assert_equal(162, M9t::Speed.new(45).to_kilometers_per_hour)
  end

  def test_mph
    assert_in_delta(100.6621, M9t::Speed.new(45).to_miles_per_hour, 0.0001)
  end

  # to_s

  def test_to_s
    assert_equal '135.00000 meters per second', M9t::Speed.new(135).to_s
    I18n.locale = :it
    assert_equal '135,00000 metri al second', M9t::Speed.new(135).to_s
  end

  def test_to_s_precision
    speed = M9t::Speed.new( 135 )

    assert_equal '135 meters per second', speed.to_s( :precision => 0 )
  end

  def test_to_s_abbreviated
    speed = M9t::Speed.new( 135 )

    assert_equal '135m/s', speed.to_s( :abbreviated => true,
                                       :precision   => 0 )
  end

  def test_to_s_knots
    speed = M9t::Speed.new( 135 )

    assert_equal '262 knots', speed.to_s( :units     => :knots,
                                          :precision => 0 )
    I18n.locale = :it
    assert_equal '262 nodi',  speed.to_s( :units     => :knots,
                                          :precision => 0 )
  end

end
