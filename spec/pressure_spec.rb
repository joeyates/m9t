# encoding: utf-8
require 'spec_helper'
require 'm9t/pressure'

describe M9t::Pressure do
  context 'class methods' do
    context '.new' do
      it 'returns the identity' do
        expect(M9t::Pressure.new(1.0).value).to eq(1.0)
      end
    end

    context 'other units' do
      [
        [:hectopascals, 0.001],
        [:inches_of_mercury, 0.03386],
      ].each do |unit, expected|
        it "handles #{unit}" do
          expect(M9t::Pressure.send(unit, 1.0).value).to be_within(expected / 1000.0).of(expected)
        end
      end
    end
  end
end

