#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'test/unit'
require File.join(File.expand_path(File.dirname(__FILE__) + '/../lib'), 'm9t')

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

  # Instance methods

  # new

  def test_unknown_units
    assert_raises(M9t::UnitError) { M9t::Temperature.new(1, {:units => :foos}) }
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
    assert_equal '135 degrees', M9t::Temperature.new(135, :precision => 0).to_s
  end

  def test_to_s_abbreviated
    assert_equal '135°C', M9t::Temperature.new(135, :abbreviated => true, :precision => 0).to_s
    assert_equal '408.15K', M9t::Temperature.new(135, :units => :kelvin, :abbreviated => true, :precision => 2).to_s
  end

  def test_to_s_kelvin
    assert_equal '373.15 kelvin', M9t::Temperature.new(100, :units => :kelvin, :precision => 2).to_s
    I18n.locale = :it
    assert_equal '373,15 kelvin', M9t::Temperature.new(100, :units => :kelvin, :precision => 2).to_s
  end

end
