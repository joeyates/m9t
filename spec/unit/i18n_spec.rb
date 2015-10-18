# encoding: utf-8
require 'spec_helper'
require 'm9t/i18n'

describe I18n do
  before do
    @old_locale = I18n.locale
  end

  after do
    I18n.locale = @old_locale
  end

  context 'languages' do
    [
      [:en, 'mile'],
      [:it, 'miglio'],
      [:de, 'Meile'],
    ].each do |locale, expected|
      it "has #{locale}" do
        I18n.locale = locale
        expect(I18n.t('units.distance.miles.full.one')).to eq(expected)
      end
    end
  end

  context 'decimal separator' do
    [
      [:en, '.'],
      [:it, ','],
    ].each do |locale, separator|
      it "has #{separator} for #{locale}" do
        I18n.locale = locale
        expect(I18n.t('numbers.decimal_separator')).to eq(separator)
      end
    end
  end

  context '.localize_float' do
    [
      [:en, '.'],
      [:it, ','],
    ].each do |locale, separator|
      it "uses the #{separator} separator in #{locale}" do
        I18n.locale = locale
        expected = "1#{separator}500000"
        expect(I18n.localize_float(1.5)).to eq(expected)
      end
    end

    it 'accepts a format indicator' do
      I18n.locale = :en
      expect(I18n.localize_float(1.5, {format: '%0.1f'})).to eq('1.5')
    end
  end
end

