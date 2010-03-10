#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'test/unit'
require File.join(File.expand_path(File.dirname(__FILE__) + '/../lib'), 'm9t')

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

  def test_class_miles_per_hour
    assert_equal(45, M9t::Speed.miles_per_hour(20.1168))
  end

  def test_class_to_miles_per_hour
    assert_equal(20.1168, M9t::Speed.to_miles_per_hour(45))
  end

  # Instance methods

  # new

  def test_unknown_units
    assert_raises(M9t::UnitError) { M9t::Speed.new('010', {:units => :foos}) }
  end

  # output conversions

  def test_kmh
    assert_equal(12.5, M9t::Speed.new(45).to_kilometers_per_hour)
  end

  def test_mph
    assert_equal(20.1168, M9t::Speed.new(45).to_miles_per_hour)
  end

  # to_s

  def test_to_s
    assert_equal '135.00000 meters per second', M9t::Speed.new(135).to_s
  end

  def test_to_s_precision
    assert_equal '135 meters per second', M9t::Speed.new(135, :precision => 0).to_s
  end

  def test_to_s_abbreviated
    assert_equal '135m/s', M9t::Speed.new(135, :abbreviated => true, :precision => 0).to_s
  end

end
