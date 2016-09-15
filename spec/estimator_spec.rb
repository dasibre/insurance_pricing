require 'spec_helper'

describe EstimateCalculator do
  subject { EstimateCalculator }

  describe '.estimate' do
    it 'calculates price for given demographics' do
      demographics = { age: '20', gender: 'male', location: 'Some Location', conditions: ['n/a']}
      expect(subject.estimate(demographics)).to eq(100)
    end
  end

  describe '#calculate' do
    let(:demographics) { { age: '20', gender: 'male', location: 'Some Location', conditions: ['n/a']} }

    context 'every 5 years over minimum age of 18' do
      specify 'exactly 5 years over age $20 increase' do
        demographics[:age] = '23'
        expect(subject.new(demographics).calculate).to eq(120)
      end

      specify 'exactly 10 years over age $40 increase' do
        demographics[:age] = '28'
        expect(subject.new(demographics).calculate).to eq(140)
      end

      specify '11 years over age $120 increase' do
        demographics[:age] = '29'
        expect(subject.new(demographics).calculate).to eq(140)
      end

      specify '32 years over age $40 increase' do
        demographics[:age] = '50'
        expect(subject.new(demographics).calculate).to eq(220)
      end
    end

    context 'when candidate under minimum age of 18' do
      it 'returns 0 for ineligible candidates' do
        demographics[:age] = '17'
        expect(subject.new(demographics).calculate).to eq(0)
      end
    end

    context 'when gender is female' do
      it 'receives $12 discount on final price' do
        demographics[:gender] = 'female'
        expect(subject.new(demographics).calculate).to eq(88)
      end
    end

    context 'location price discount' do
      it 'receives 5 percent discount for east coast' do
        demographics[:location] = 'New York'
        expect(subject.new(demographics).calculate).to eq(95)
      end
    end

    context 'pre-condition price adjustments' do
      it 'increases by 1 percent for allergies' do
        demographics[:conditions] = ['Allergies']
        expect(subject.new(demographics).calculate).to eq(101)
      end

      context 'when candidate has more than one health condition' do
        it 'makes correct price adjustments for each condition' do
          demographics = { age: '30', gender: 'female', location: 'New York', conditions: ['Heart Disease', 'High Cholesterol']}
          expect(subject.new(demographics).calculate).to eq(154.25)
        end
      end

      it 'increases by 6 percent for sleep apnea' do
        demographics[:conditions] = ['Sleep Apnea']
        expect(subject.new(demographics).calculate).to eq(106)
      end

      it 'increases by 4 percent for asthma' do
        demographics[:conditions] = ['Asthma']
        expect(subject.new(demographics).calculate).to eq(104)
      end

      it 'increases by 17 percent for heart disease' do
        demographics[:conditions] = ['Heart Disease']
        expect(subject.new(demographics).calculate).to eq(117)
      end

      it 'increases by 8 percent for high cholesterol' do
        demographics[:conditions] = ['High Cholesterol']
        expect(subject.new(demographics).calculate).to eq(108)
      end
    end
  end
end
