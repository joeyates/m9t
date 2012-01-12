# encoding: utf-8

require File.expand_path( 'test_helper', File.dirname( __FILE__ ) )

class TestM9tTemperature < Test::Unit::TestCase

  def setup
    I18n.locale = :en
    M9t::Temperature.reset_options!
  end

  # Basic use
  def test_new
    assert_equal(45, M9t::Temperature.new(45).value)
  end

  # Class methods

  # Base class

  def test_measurement_name
    assert_equal('temperature', M9t::Temperature.measurement_name)
  end

  # conversion constants

  def test_kelvin_offset
    assert_in_delta(-273.15, M9t::Temperature::ABSOLUTE_ZERO, 0.0001)
  end

  # input conversions

  def test_class_kelvin
    assert_in_delta(-273.15, M9t::Temperature.kelvin(0).value, 0.0001)
  end

  def test_class_fahrenheit
    assert_in_delta(-17.7777, M9t::Temperature.fahrenheit(0).value, 0.0001)
  end

  # output conversions

  def test_class_to_kelvin
    assert_in_delta(273.15, M9t::Temperature.to_kelvin(0), 0.0001)
  end

  def test_class_to_fahrenheit
    assert_in_delta(32, M9t::Temperature.to_fahrenheit(0), 0.0001)
  end

  def test_class_kelvin_to_degrees
    assert_in_delta(-273.15, M9t::Temperature.kelvin_to_degrees(0), 0.0001)
  end

  # Instance methods

  # new

  def test_unknown_units
    temperature = M9t::Temperature.new( 1 )

    assert_raises( M9t::UnitError ) do 
      temperature.to_s( :units => :foos )
    end
  end

  # output conversions

  def test_to_kelvin
    assert_equal(373.15, M9t::Temperature.new(100).to_kelvin)
  end

  def test_to_fahrenheit
    assert_equal(212, M9t::Temperature.new(100).to_fahrenheit)
  end

  # to_s

  def test_to_s
    assert_equal '100.00000 degrees', M9t::Temperature.new(100).to_s
    I18n.locale = :it
    assert_equal '100,00000 gradi', M9t::Temperature.new(100).to_s
  end

  def test_to_s_precision
    temperature = M9t::Temperature.new( 135 )

    assert_equal '135 degrees', temperature.to_s( :precision => 0 )
  end

  def test_to_s_abbreviated
    temperature = M9t::Temperature.new( 135 )

    assert_equal '135°C',   temperature.to_s( :abbreviated => true,
                                              :precision   => 0 )
    assert_equal '408.15K', temperature.to_s( :units       => :kelvin,
                                              :abbreviated => true,
                                              :precision   => 2 )
  end

  def test_to_s_kelvin
    temperature = M9t::Temperature.new( 100 )

    assert_equal '373.15 kelvin', temperature.to_s( :units     => :kelvin,
                                                    :precision => 2 )
    I18n.locale = :it
    assert_equal '373,15 kelvin', temperature.to_s( :units     => :kelvin,
                                                    :precision => 2 )
  end

end
