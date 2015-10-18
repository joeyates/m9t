# encoding: utf-8
require 'spec_helper'
require 'm9t/base'

class SomeMeasurement
  DEFAULT_OPTIONS = {
    units:       :foos,
    abbreviated: false,
    decimals:    1
  }
  CONVERSIONS = {
    foos: 1.0,
    bars: 1 / 42.0
  }

  include M9t::Base
end

class SomeDerivedMeasurement < SomeMeasurement; end

describe M9t::Base do
  describe '.respond_to?' do
    it 'is true for conversion between known units' do
      expect(SomeMeasurement.respond_to?(:foos_to_bars)).to be_truthy
    end

    it 'is false for unknown units' do
      expect(SomeMeasurement.respond_to?(:bazs_to_bars)).to be_falsey
    end
  end

  describe '.method_missing' do
    it 'handles conversion between known units' do
      expect(SomeMeasurement.foos_to_bars(3.0)).to be_a(Float)
    end

    it 'fails for unknown units' do
      expect {
        SomeMeasurement.bazs_to_bars(3.0)
      }.to raise_error(NoMethodError)
    end
  end

  describe '#respond_to?' do
    subject { SomeMeasurement.new(3.0) }

    it 'is true for conversion to known units' do
      expect(subject.respond_to?(:to_bars)).to be_truthy
    end

    it 'is false for unknown units' do
      expect(subject.respond_to?(:to_bazs)).to be_falsey
    end

    context 'for unrecognized calls' do
      it 'calls super' do
        expect(subject.respond_to?(:ciao)).to be_falsey
      end
    end
  end

  describe '#method_missing' do
    subject { SomeMeasurement.new(3.0) }

    it 'handles conversion to known units' do
      expect(subject.to_bars).to be_a(Float)
    end

    it 'fails for unknown units' do
      expect {
        subject.to_bazs(3.0)
      }.to raise_error(NoMethodError)
    end
  end

  describe 'derived class' do
    it 'inherits options' do
      expect(SomeDerivedMeasurement.options).to eq(SomeMeasurement.options)
    end
  end
end
