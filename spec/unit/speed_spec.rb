# encoding: utf-8
require 'spec_helper'
require 'm9t/speed'

describe M9t::Speed do
  context 'conversion constants' do
    it 'has knots' do
      expect(M9t::Speed::KNOTS).to be_within(0.0001).of(1.9438)
    end
  end

  context 'known units' do
    it 'gives an error for unknown units' do
      speed = M9t::Speed.new(10)
      expect {
        speed.to_s(units: :foos)
      }.to raise_error(M9t::UnitError)
    end
  end

  context 'class methods' do
    context '.new' do
      it 'handles identity' do
        expect(M9t::Speed.new(45).value).to eq(45)
      end
    end

    context '.measurement_name' do
      it "is 'speed'" do
        expect(M9t::Speed.measurement_name).to eq('speed')
      end
    end

    context 'conversion factories' do
      [
        [:kilometers_per_hour, 0.2778],
        [:miles_per_hour, 0.447],
        [:knots, 0.5144],
      ].each do |unit, expected|
        specify unit do
          expect(M9t::Speed.send(unit, 1.0).value).to be_within(0.0001).of(expected)
        end
      end
    end

    context 'conversions' do
      [
        [:meters_per_second, :miles_per_hour, 45.0, 100.6621],
      ].each do |from, to, input, expected|
        method = :"#{from}_to_#{to}"
        specify method do
          expect(M9t::Speed.send(method, input)).to be_within(0.0001).of(expected)
        end
      end
    end
  end

  context 'conversions' do
    subject { M9t::Speed.new(45) }

    [
      [:kilometers_per_hour, 162.0],
      [:miles_per_hour, 100.6621],
    ].each do |unit, expected|
      method = :"to_#{unit}"
      specify method do
        expect(subject.send(method)).to be_within(expected / 1000.0).of(expected)
      end
    end
  end

  context '#to_s' do
    subject { M9t::Speed.new(135.0) }

    specify 'full en' do
      I18n.locale = :en
      expect(subject.to_s).to eq('135.00000 meters per second')
    end

    specify 'full it' do
      I18n.locale = :it
      expect(subject.to_s).to eq('135,00000 metri al second')
    end

    specify 'precision' do
      I18n.locale = :en
      expect(subject.to_s(precision: 0)).to eq('135 meters per second')
    end

    specify 'abbreviated' do
      expect(subject.to_s(abbreviated: true, precision: 0)).to eq('135m/s')
    end

    specify 'units: knots, en' do
      I18n.locale = :en
      expect(subject.to_s(units: :knots, precision: 0)).to eq('262 knots')
    end

    specify 'units: knots, it' do
      I18n.locale = :it
      expect(subject.to_s(units: :knots, precision: 0)).to eq('262 nodi')
    end
  end
end

