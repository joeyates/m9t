# encoding: utf-8
require 'spec_helper'

class SomeMeasurement
  DEFAULT_OPTIONS = {
    :units       => :foos,
    :abbreviated => false,
    :decimals    => 1
  }
  CONVERSIONS = {
    :foos =>      1.0,
    :bars => 1 / 42.0
  }

  include M9t::Base
end

class SomeDerivedMeasurement < SomeMeasurement; end

describe M9t::Base do
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

