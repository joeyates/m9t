# encoding: utf-8
require 'spec_helper'
require 'm9t/direction'

describe M9t::Direction do
  before do
    I18n.locale = :en
  end

  describe '.measurement_name' do
    it "is 'direction'" do
      expect(M9t::Direction.measurement_name).to eq('direction')
    end
  end

  describe '.options' do
    it 'is set' do
      expect(M9t::Direction.options).not_to be_nil
    end

    context 'abbreviated' do
      it 'is false' do
        expect(M9t::Direction.options[:abbreviated]).to be_falsey
      end
    end

    context 'units' do
      it 'is degrees' do
        expect(M9t::Direction.options[:units]).to eq(:degrees)
      end
    end
  end

  describe '.normalize' do
    it 'handles values > 360' do
      expect(M9t::Direction.normalize(725)).to eq(5)
    end

    it 'handles values < 0' do
      expect(M9t::Direction.normalize(-355)).to eq(5)
    end
  end

  context 'conversion class methods' do
    describe '.degrees_to_degrees' do
      it 'returns the identity' do
        expect(M9t::Direction.degrees_to_degrees(45)).to eq(45)
      end
    end

    describe '.degrees_to_compass' do
      before do
        I18n.locale = :en
      end

      context 'exact' do
        [
          'N', 'NNE', 'NE', 'ENE',
          'E', 'ESE', 'SE', 'SSE',
          'S', 'SSW', 'SW', 'WSW',
          'W', 'WNW', 'NW', 'NNW'
        ].each.with_index do |result, i|
          it "recognizes #{result}" do
            expect(M9t::Direction.degrees_to_compass(i * 22.5)).to eq(result)
          end
        end
      end

      context 'rounding' do
        specify 'up' do
          expect(M9t::Direction.degrees_to_compass(42)).to eq('NE')
        end

        specify 'down' do
          expect(M9t::Direction.degrees_to_compass(93)).to eq('E')
        end
      end

      context 'i18n' do
        before do
          I18n.locale = :it
        end

        it 'translates' do
          expect(M9t::Direction.degrees_to_compass(270)).to eq('O')
        end
      end
    end

    describe 'compass_to_degrees' do
      it 'converts correctly' do
        expect(M9t::Direction.compass_to_degrees('WSW')).to eq(247.5)
      end
    end
  end

  describe '.new' do
    context 'strings' do
      it 'works' do
        expect(M9t::Direction.new('35').value).to eq(35)
      end

      it 'handles leading zeroes' do
        expect(M9t::Direction.new('010').value).to eq(10)
      end
    end
  end

  describe '.compass' do
    it 'converts cardinals' do
      expect(M9t::Direction.compass('N').value).to eq(0)
    end

    it 'handles 16ths' do
      expect(M9t::Direction.compass('WSW').value).to eq(247.5)
    end
  end

  describe '#value' do
    let(:degrees) { M9t::Direction.new(45) }

    it 'returns the supplied value' do
      expect(degrees.value).to eq(45)
    end
  end

  describe '#to_s' do
    context 'not abbreviated' do
      context 'singular' do
        subject { M9t::Direction.new(1) }

        it 'returns the full unit name' do
          expect(subject.to_s).to eq('1 degree')
        end

        it 'translates' do
          I18n.locale = :it
          expect(subject.to_s).to eq('1 grado')
        end
      end

      context 'plural' do
        subject { M9t::Direction.new(135) }

        it 'returns the full unit name' do
          expect(subject.to_s).to eq('135 degrees')
        end

        it 'translates' do
          I18n.locale = :it
          expect(subject.to_s).to eq('135 gradi')
        end
      end
    end

    context 'abbreviated' do
      subject { M9t::Direction.new(135) }

      it 'uses the symbol' do
        expect(subject.to_s(abbreviated: true)).to eq('135°')
      end
    end

    context 'compass units' do
      subject { M9t::Direction.new(225) }

      it 'works' do
        expect(subject.to_s(units: :compass)).to eq('SW')
      end

      it 'translates' do
        I18n.locale = :it
        expect(subject.to_s(units: :compass)).to eq('SO')
      end
    end
  end

  describe '#to_compass' do
    subject { M9t::Direction.new(0) }

    it 'is correct' do
      expect(subject.to_compass).to eq('N')
    end
  end
end

