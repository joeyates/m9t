# encoding: utf-8
require 'spec_helper'
require 'm9t/distance'

describe M9t::Distance do
  context 'class methods' do
    it 'has a measurement name' do
      expect(M9t::Distance.measurement_name).to eq('distance')
    end

    context 'default options' do
      it 'has options' do
        expect(M9t::Distance.options).not_to be_nil
      end

      it 'not abbreviated' do
        expect(M9t::Distance.options[:abbreviated]).to be_falsey
      end

      it 'units: meters' do
        expect(M9t::Distance.options[:units]).to be(:meters)
      end

      it 'precision: 5' do
        expect(M9t::Distance.options[:precision]).to eq(5)
      end
    end

    it 'constructs from meters' do
      expect(M9t::Distance.new(0.3).to_f).to eq(0.3)
    end

    context 'units factories' do
      [
        [:meters, 0.3, 0.3],
        [:kilometers, 0.3, 300.0],
        [:miles, 26.21875, 42194.988]
      ].each do |unit, input, result|
        it "#{unit} constructs correctly" do
          distance = M9t::Distance.send(unit, input)
          expect(distance.to_f).to be_within(0.0001).of(result)
        end
      end
    end

    context 'conversions' do
      [
        ['meters', 'kilometers', 0.3, 0.0003],
        ['miles', 'kilometers', 26.21875, 42.194988]
      ].each do |from, to, input, expected|
        method = :"#{from}_to_#{to}"
        specify method do
          expect(M9t::Distance.send(method, input)).to eq(expected)
        end
      end
    end
  end

  context '.conversions' do
    specify '#to_meters' do
      expect(M9t::Distance.new(0.3).to_meters).to eq(0.3)
    end

    specify '#to_kilometers' do
      expect(M9t::Distance.new(0.3).to_kilometers).to eq(0.0003)
    end

    specify '#to_feet' do
      expect(M9t::Distance.new(0.3).to_feet).to be_within(0.00001).of(0.98425)
    end
  end

  context '#to_s' do
    before do
      I18n.locale = :en
    end

    it 'handles singluar' do
      distance = M9t::Distance.new(1)
      expect(distance.to_s(precision: 0)).to eq('1 meter')
    end

    it 'handles plural' do
      distance = M9t::Distance.new(10)
      expect(distance.to_s(precision: 0)).to eq('10 meters')
    end

    it 'handles abbreviation' do
      distance = M9t::Distance.new(0.3)
      expect(distance.to_s(abbreviated: true)).to eq('0.30000m')
    end

    specify 'units: kilometers' do
      distance = M9t::Distance.new( 156003 )
      expect(distance.to_s(precision: 1, units: :kilometers)).to eq('156.0 kilometers')
    end

    specify 'units: miles, singular' do
      marathon = M9t::Distance.miles(26.21875)
      expect(marathon.to_s(units: :miles, precision: 0)).to eq('26 miles')
    end

    specify 'units: miles, plural' do
      ten_km = M9t::Distance.new(10000)
      expect(ten_km.to_s(units: :miles, precision: 1)).to eq('6.2 miles')
    end

    context 'i18n' do
      before do
        I18n.locale = :it
      end

      specify 'precision: 0' do
        distance = M9t::Distance.new(10)
        expect(distance.to_s(precision: 0)).to eq('10 metri')
      end

      specify 'units: miles' do
        marathon = M9t::Distance.miles(26.21875)
        expect(marathon.to_s(units: :miles, precision: 0)).to eq('26 miglia')
      end

      specify 'units: miles, precision: 1' do
        ten_km = M9t::Distance.new(10000)
        expect(ten_km.to_s(units: :miles, precision: 1)).to eq('6,2 miglia')
      end
    end
  end
end

