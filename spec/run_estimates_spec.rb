require './run_estimates'

describe 'EstimateRunner' do
  describe '.run' do
    it 'runs insurance estimates for given data' do
      data      = [['first_name', 'Age', 'Gender', 'Location', 'Health Conditions'], ['Brad', '20', 'male', 'San Francisco', 'n/a'],]
      estimator = double('Estimator')
      allow(EstimateRunner).to receive(:estimate_calculator).and_return(estimator)
      expect(estimator).to receive(:estimate).and_return('100')
      expect(EstimateRunner.run(data)).to match_array(["Brad's policy is estimated at $100"])
    end
  end
end