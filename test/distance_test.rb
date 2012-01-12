# encoding: utf-8

require File.expand_path( 'test_helper', File.dirname( __FILE__ ) )

class TestM9tDistance < Test::Unit::TestCase

  def setup
    I18n.locale = :en
    M9t::Distance.reset_options!
  end

  # Basic use
  def test_singular
    distance = M9t::Distance.new( 1 )
    I18n.locale = :en

    assert_equal('1 meter', distance.to_s( :precision => 0 ) )
  end

  def test_plural
    distance = M9t::Distance.new( 10 )

    I18n.locale = :en
    assert_equal( '10 meters', distance.to_s( :precision => 0 ) )
    I18n.locale = :it
    assert_equal( '10 metri', distance.to_s( :precision => 0 ) )
  end

  # Class methods

  # Base class

  def test_unit_name
    assert_equal('distance', M9t::Distance.measurement_name)
  end

  # Construction
  # ...from meters
  def test_new
    assert_equal(0.3, M9t::Distance.new(0.3).to_f)
  end

  def test_class_meters
    assert_equal(0.3, M9t::Distance.meters(0.3).to_f)
  end

  # ...from other units
  def test_class_kilometers
    assert_in_delta(300.0, M9t::Distance.kilometers(0.3).to_f, 0.00001)
  end

  def test_class_miles
    assert_in_delta(1609.344, M9t::Distance.miles(1).to_f, 0.00001)
    assert_in_delta(42194.988, M9t::Distance.miles(26.21875).to_f, 0.00001)
  end

  # Conversion class methods
  # ...to other units
  def test_class_meters_to_kilometers
    assert_equal(0.0003, M9t::Distance.meters_to_kilometers(0.3))
  end

  def test_class_miles_to_kilometers
    assert_in_delta(42.194988, M9t::Distance.miles_to_kilometers(26.21875), 0.00001)
  end

  # Default options

  def test_default_options_set
    assert_not_nil(M9t::Distance.options)
  end

  def test_default_option_abbreviated
    assert(! M9t::Distance.options[:abbreviated])
  end

  def test_default_option_units
    assert_equal(:meters, M9t::Distance.options[:units])
  end

  def test_default_option_decimals
    assert_equal(5, M9t::Distance.options[:precision])
  end

  # Instance methods

  # Conversion
  def test_instance_to_meters
    assert_equal(0.3, M9t::Distance.new(0.3).to_meters)
  end

  def test_instance_to_kilometers
    assert_equal(0.0003, M9t::Distance.new(0.3).to_kilometers)
  end

  def test_instance_to_kilometers
    assert_in_delta(0.98425, M9t::Distance.new(0.3).to_feet, 0.00001)
  end

  # to_s
  def test_to_s_singular
    assert_equal('1.00000 meter', M9t::Distance.new(1).to_s)
  end

  def test_to_s_plural
    assert_equal('0.30000 meters', M9t::Distance.new(0.3).to_s)
  end

  # i18n
  def test_to_s_plural_abbreviated
    distance = M9t::Distance.new( 10 )
    I18n.locale = :en
    assert_equal( '10m', distance.to_s( :abbreviated => true,
                                        :precision   => 0 ) )
    I18n.locale = :it
    assert_equal( '10m', distance.to_s( :abbreviated => true,
                                        :precision   => 0 ) )
  end

  def test_to_s_abbreviated
    distance = M9t::Distance.new( 0.3 )

    assert_equal( '0.30000m', distance.to_s( :abbreviated => true ) )
  end

  def test_to_s_precision
    distance = M9t::Distance.new( 0.3 )

    assert_equal( '0.3m', distance.to_s( :precision   => 1,
                                         :abbreviated => true ) )
  end

  def test_to_s_kilometers
    distance = M9t::Distance.new( 156003 )

    assert_equal( '156.0 kilometers', distance.to_s( :precision => 1,
                                                     :units     => :kilometers ) )
  end

  def test_miles_singular
    marathon = M9t::Distance.miles( 26.21875 )
    I18n.locale = :en
    assert_equal( '26 miles', marathon.to_s( :units     => :miles,
                                             :precision => 0 ) )
    I18n.locale = :it
    assert_equal( '26 miglia', marathon.to_s( :units     => :miles,
                                              :precision => 0 ) )
  end

  def test_to_s_miles_plural
    ten_km = M9t::Distance.new( 10000 )

    I18n.locale = :en
    assert_equal( '6.2 miles', ten_km.to_s( :units     => :miles,
                                            :precision => 1 ) )
    I18n.locale = :it
    assert_equal( '6,2 miglia', ten_km.to_s( :units     => :miles,
                                             :precision => 1 ) )
  end

end
