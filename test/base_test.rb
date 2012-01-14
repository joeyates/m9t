# encoding: utf-8

require File.expand_path( 'test_helper', File.dirname( __FILE__ ) )

class SomeMeasurement
  DEFAULT_OPTIONS = {:units => :foos, :abbreviated => false, :decimals => 1}
  CONVERSIONS     = {:foos =>      1.0,
                     :bars => 1 / 42.0}

  include M9t::Base
end

class SomeDerivedMeasurement < SomeMeasurement
end

class TestM9tBase < Test::Unit::TestCase

  def setup
    I18n.locale = :en
    SomeMeasurement.reset_options!
  end

  # class methods

  def test_class_method_missing_for_known_units
    assert_in_delta(0.0714, SomeMeasurement.foos_to_bars(3.0), 0.001)
  end

  def test_class_method_missing_fails_on_unknown_units
    assert_raise(RuntimeError) do
      SomeMeasurement.bazs_to_bars(3.0)
    end
  end

  # instance methods

  def test_instance_method_missing_for_known_units
    some = SomeMeasurement.new(3.0)
    assert_in_delta(0.0714, some.to_bars(3.0), 0.001)
  end

  def test_instance_method_missing_fails_on_unknown_units
    some = SomeMeasurement.new(3.0)
    assert_raise(RuntimeError) do
      some.to_bazs(3.0)
    end
  end

  # derived classes

  def test_derived_class_gets_options
    assert_equal(SomeMeasurement.options, SomeDerivedMeasurement.options)
  end

end
