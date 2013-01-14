# encoding: utf-8

require File.expand_path( 'test_helper', File.dirname( __FILE__ ) )

class TestI18nMonkeyPatching < Test::Unit::TestCase
  def setup
    @old_locale = I18n.locale
  end

  def teardown
    I18n.locale = @old_locale
  end

  def test_english_loaded
    I18n.locale = :en
    assert_equal('.', I18n.t('numbers.decimal_separator'))
  end

  def test_italian_loaded
    I18n.locale = :it
    assert_equal(',', I18n.t('numbers.decimal_separator'))
  end

  def test_german_loaded
    I18n.locale = :de
    assert_equal('Meile', I18n.t('units.distance.miles.full.one'))
  end

  def test_localize_float_default
    assert_equal('1.500000', I18n.localize_float(1.5))
  end

  def test_localize_float_formatted
    assert_equal('1.5', I18n.localize_float(1.5, {:format => '%0.1f'}))
  end

  def test_localize_float_italian
    I18n.locale = :it
    assert_equal('1,5', I18n.localize_float(1.5, {:format => '%0.1f'}))
  end
end

