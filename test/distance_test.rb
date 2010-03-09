#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'test/unit'
require File.join(File.expand_path(File.dirname(__FILE__) + '/../lib'), 'm9t')

class TestM9tDistance < Test::Unit::TestCase
  
  def setup
    I18n.locale = :en
    M9t::Distance.reset_options!
  end

  # Basic use
  def test_distance_singular
    distance = M9t::Distance.new(1, :precision => 0)
    I18n.locale = :en
    assert_equal('1 meter', distance.to_s)
  end

  def test_distance_plural
    distance = M9t::Distance.new(10, :precision => 0)
    I18n.locale = :en
    assert_equal('10 meters', distance.to_s)
    I18n.locale = :it
    assert_equal('10 metri', distance.to_s)
  end

  # Class methods

  # Conversion from non-SI units
  def test_kilometers
    assert_equal(300.0, M9t::Distance.kilometers(0.3))
  end

  def test_miles
    assert_equal(0.3 * 1609.344, M9t::Distance.miles(0.3))
  end

  # Conversion to non-SI units
  def test_class_to_meters
    assert_equal(0.3, M9t::Distance.to_meters(0.3))
  end

  def test_class_to_kilometers
    assert_equal(0.0003, M9t::Distance.to_kilometers(0.3))
  end

  def test_distance_default_options_set
    assert_not_nil(M9t::Distance.options)
  end

  def test_distance_default_option_abbreviated
    assert(! M9t::Distance.options[:abbreviated])
  end

  def test_distance_default_option_units
    assert_equal(:meters, M9t::Distance.options[:units])
  end

  def test_distance_default_option_decimals
    assert_equal(5, M9t::Distance.options[:precision])
  end

  # Instance methods

  def test_new
    assert_equal(0.3, M9t::Distance.new(0.3).value)
  end

  def test_distance_default_options_merged
    distance = M9t::Distance.new(10, {:abbreviated => true})
    assert_equal(:meters, distance.options[:units])
    assert_equal(5, distance.options[:precision])
  end

  def test_distance_set_default_options_get_inherited
    M9t::Distance.options[:precision] = 0
    distance = M9t::Distance.new(10)
    assert_equal(0, distance.options[:precision])
  end

  def test_to_meters
    assert_equal(0.3, M9t::Distance.new(0.3).to_meters)
  end

  def test_to_kilometers
    assert_equal(0.0003, M9t::Distance.new(0.3).to_kilometers)
  end

  def test_to_s_singular
    assert_equal('1.00000 meter', M9t::Distance.new(1).to_s)
  end

  def test_to_s_plural
    assert_equal('0.30000 meters', M9t::Distance.new(0.3).to_s)
  end

  def test_to_s_plural_abbreviated
    distance = M9t::Distance.new(10, {:abbreviated => true, :precision => 0})
    I18n.locale = :en
    assert_equal('10m', distance.to_s)
    I18n.locale = :it
    assert_equal('10m', distance.to_s)
  end

  def test_to_s_abbreviated
    assert_equal('0.30000m', M9t::Distance.new(0.3, {:abbreviated => true}).to_s)
  end

  def test_to_s_precision
    assert_equal('0.3m', M9t::Distance.new(0.3, {:precision => 1, :abbreviated => true}).to_s)
  end

  def test_to_s_kilometers
    assert_equal('156.0 kilometers', M9t::Distance.new(156003, {:precision => 1, :units => :kilometers}).to_s)
  end

  def test_miles_singular
    distance = M9t::Distance.new(M9t::Distance.miles(1), {:units => :miles, :precision => 0})
    I18n.locale = :en
    assert_equal(distance.to_s, '1 mile')
    I18n.locale = :it
    assert_equal(distance.to_s, '1 miglio')
  end

  def test_to_s_miles_plural
    distance = M9t::Distance.new(10000, {:units => :miles, :precision => 1})
    I18n.locale = :en
    assert_equal('6.2 miles', distance.to_s)
    I18n.locale = :it
    assert_equal('6,2 miglia', distance.to_s)
  end

end
