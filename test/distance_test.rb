#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'test/unit'
require File.join(File.expand_path(File.dirname(__FILE__) + '/../lib'), 'm9t')

class TestM9tDistance < Test::Unit::TestCase
  
  def setup
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

  def test_new
    assert_equal(0.3, M9t::Distance.new(0.3).value)
  end

  def test_to_meters
    assert_equal(0.3, M9t::Distance.new(0.3).to_meters)
  end

  def test_to_kilometers
    assert_equal(0.0003, M9t::Distance.new(0.3).to_kilometers)
  end

  def test_to_s
    assert_equal('0.30000 meters', M9t::Distance.new(0.3).to_s)
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

  def test_to_s_miles
    assert_equal('96.9 miles', M9t::Distance.new(156003, {:precision => 1, :units => :miles}).to_s)
  end

end
