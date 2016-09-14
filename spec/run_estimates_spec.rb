data = [
	     ["first_name","Age","Gender","Location", "Health Conditions"],
	     ["Brad", "20", "male", "San Francisco", "n/a"],
	     ["Stan", "10", "male", "San Francisco", "Asthma"]
       ]


module EstimateRunner
	class << self
	  def run(data)
	  	results = []
	  	estimate = estimate_calculator.calculate()
	  	results << "Brad's policy is estimated at $#{estimate}"
	  end

	  private

	  def estimate_calculator
	  	Estimator
	  end

	  def parse_data
	  end
	end
end

describe 'EstimateRunner' do
	describe '.run' do
		it 'runs insurance estimates for given data' do
		  data = [["first_name","Age","Gender","Location", "Health Conditions"],["Brad", "20", "male", "San Francisco", "n/a"],]
		  estimator = double('Estimator')
		  allow(EstimateRunner).to receive(:estimate_calculator).and_return(estimator)	
		  allow(estimator).to receive(:calculate).and_return("100")
		  expect(EstimateRunner.run(data)).to match_array(["Brad's policy is estimated at $100"])
		end

		it 'runs insurance estimates for given data' do
		  estimator = double('Estimator')
		  allow(EstimateRunner).to receive(:estimate_calculator).and_return(estimator)	
		  allow(estimator).to receive(:calculate).and_return("100")
		  expect(EstimateRunner.run(data)).to match_array(["Stan's policy is estimated at $100"])
		end
	end
end

#given data input
#when i run estimate
#I should get Estimate results

#EstimateRunner.run(data)