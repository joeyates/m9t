# encoding: utf-8
require 'm9t/temperature'

describe M9t::Temperature do
  context 'constants' do
    specify 'absolute zero' do
      expect(M9t::Temperature::ABSOLUTE_ZERO).to be_within(0.0001).of(-273.15)
    end
  end

  context 'default options' do
    specify 'units: meters' do
      expect(M9t::Temperature.options[:units]).to eq(:degrees)
    end

    specify 'precision: 2' do
      expect(M9t::Temperature.options[:precision]).to eq(5)
    end
  end

  context 'class methods' do
    context '.new' do
      it 'handles identity' do
        expect(M9t::Temperature.new(45.0).value).to eq(45.0)
      end
    end

    context '.measurement_name' do
      it "is 'temperature'" do
        expect(M9t::Temperature.measurement_name).to eq('temperature')
      end
    end

    context 'conversion factories' do
      [
        [:kelvin, -273.15],
        [:fahrenheit, -17.77777778],
      ].each do |unit, expected|
        specify unit do
          expect(M9t::Temperature.send(unit, 0.0).value).to be_within(expected.abs / 1000.0).of(expected)
        end
      end
    end

    context 'conversions' do
      [
        [:kelvin, 273.15],
        [:fahrenheit, 32.0],
      ].each do |unit, expected|
        method = :"to_#{unit}"
        specify method do
          expect(M9t::Temperature.send(method, 0)).to eq(expected)
        end
      end
    end
  end

  context 'conversions' do
    subject { M9t::Temperature.new(100) }

    [
      [:kelvin, 373.15],
      [:fahrenheit, 212.0],
    ].each do |unit, expected|
      method = :"to_#{unit}"
      specify method do
        expect(subject.send(method)).to be_within(expected.abs / 1000.0).of(expected)
      end
    end
  end

  context '#to_s' do
    subject { M9t::Temperature.new(135) }

    specify 'en' do
      I18n.locale = :en
      expect(subject.to_s).to eq('135.00000 degrees')
    end

    specify 'it' do
      I18n.locale = :it
      expect(subject.to_s).to eq('135,00000 gradi')
    end

    specify 'precision' do
      I18n.locale = :en
      expect(subject.to_s(:precision => 0)).to eq('135 degrees')
    end

    specify 'abbreviated, en' do
      I18n.locale = :en
      expect(subject.to_s(:abbreviated => true, :precision => 0)).to eq('135°C')
    end

    specify 'kelvin, en' do
      I18n.locale = :en
      expect(subject.to_s(:units => :kelvin, :precision => 2)).to eq('408.15 kelvin')
    end

    specify 'kelvin, it' do
      I18n.locale = :it
      expect(subject.to_s(:units => :kelvin, :precision => 2)).to eq('408,15 kelvin')
    end

    specify 'abbreviated, kelvin, it' do
      I18n.locale = :it
      expect(subject.to_s(:units => :kelvin, :abbreviated => true, :precision => 2)).to eq('408,15K')
    end
  end
end

