# encoding: utf-8
require 'spec_helper'
require 'm9t/temperature'

describe M9t::Temperature do
  CONVERSIONS = [
    [:kelvin, 100, 373.15],
    [:fahrenheit, 100, 212.0],
  ]

  context 'constants' do
    specify 'absolute zero' do
      expect(M9t::Temperature::ABSOLUTE_ZERO).to be_within(0.0001).of(-273.15)
    end
  end

  context 'default options' do
    specify 'units: meters' do
      expect(M9t::Temperature.options[:units]).to eq(:degrees)
    end

    specify 'precision: 5' do
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
      CONVERSIONS.each do |unit, degrees, other|
        specify ".#{unit}" do
          expect(M9t::Temperature.send(unit, other).value).
            to be_within(degrees.abs / 1000.0).of(degrees)
        end
      end
    end

    context 'conversions' do
      context 'from degrees' do
        CONVERSIONS.each do |unit, degrees, other|
          method = :"to_#{unit}"
          specify method do
            expect(M9t::Temperature.send(method, degrees)).to eq(other)
          end
        end
      end

      context 'to degrees' do
        CONVERSIONS.each do |unit, degrees, other|
          method = :"#{unit}_to_degrees"
          specify method do
            expect(M9t::Temperature.send(method, other)).to eq(degrees)
          end
        end
      end
    end
  end

  context 'conversions' do
    context 'from degrees' do
      CONVERSIONS.each do |unit, degrees, other|
        subject { M9t::Temperature.new(degrees) }

        method = :"to_#{unit}"
        specify method do
          expect(subject.send(method)).to be_within(other.abs / 1000.0).of(other)
        end
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
      expect(subject.to_s(precision: 0)).to eq('135 degrees')
    end

    specify 'abbreviated, en' do
      I18n.locale = :en
      expect(subject.to_s(abbreviated: true, precision: 0)).
        to eq('135°C')
    end

    specify 'kelvin, en' do
      I18n.locale = :en
      expect(subject.to_s(units: :kelvin, precision: 2)).
        to eq('408.15 kelvin')
    end

    specify 'kelvin, it' do
      I18n.locale = :it
      expect(subject.to_s(units: :kelvin, precision: 2)).
        to eq('408,15 kelvin')
    end

    specify 'abbreviated, kelvin, it' do
      I18n.locale = :it
      expect(
        subject.to_s(units: :kelvin, abbreviated: true, precision: 2)
      ).to eq('408,15K')
    end
  end
end

