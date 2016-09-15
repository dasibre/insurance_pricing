$LOAD_PATH.unshift File.expand_path('./lib', File.dirname(__FILE__))
require 'estimator'

module EstimateRunner
  class << self
    def run(data)
      hash_data = table_to_hash(data)
      hash_data.map do |ind|
        ind['estimate'] = estimate_calculator.estimate({ age: ind['age'], gender: ind['gender'], location: ind['location'], conditions: ind['health_conditions'] })
        if ind['estimate'] == 0
          p "#{ind['first_name']} is not eligible for a life insurance policy"
        else
          p "#{ind['first_name']}'s policy is estimated at $#{ind['estimate']}"
        end
      end
    end

    private

    def estimate_calculator
      EstimateCalculator
    end

    def table_to_hash(tabular_data)
      data     = tabular_data.clone
      headings = data.shift
      data.map do |row|
        row_hash = {}
        row.each_with_index do |_, idx|
          header = headings[idx]
          if header == 'Health Conditions'
            row_hash[header.downcase.tr(' ', '_')] = row[idx].split(',')
          else
            row_hash[header.downcase.tr(' ', '_')] = row[idx]
          end
        end
        row_hash
      end
    end
  end
end

data = [
    ['first_name', 'Age', 'Gender', 'Location', 'Health Conditions'],
    ['Kelly', '50', 'female', 'Boston', 'Allergies'],
    ['Josh', '40', 'male', 'Seattle', 'Sleep Apnea'],
    ['Jan', '30', 'female', 'New York', 'Heart Disease,High Cholesterol'],
    ['Brad', '20', 'male', 'San Francisco', 'n/a'],
    ['Petr', '10', 'male', 'Los Angeles', 'Asthma']
]

EstimateRunner.run(data)
