class EstimateCalculator
	class << self
		def estimate(opts = {})
			new(opts).calculate
		end
	end

	attr_reader :age, :gender, :location, :conditions, :base_cost

	def initialize(attrs = {})
		@age = attrs.fetch(:age).to_i
		@gender = attrs.fetch(:gender)
		@location = attrs.fetch(:location)
		@conditions = attrs.fetch(:conditions)
		@base_cost = individual_base_cost
	end

	def calculate
		return 0 if age < minimum_age_eligibility
		final_price = apply_price_adjustments
	end

	private

	def individual_base_cost
		age_based_price_inc * ((age - minimum_age_eligibility) / 5) + annual_base_cost
	end

	def annual_base_cost
		100
	end

  def apply_price_adjustments
		adjusted_price = base_cost - (base_cost * location_discount).to_i
		adjusted_price = adjusted_price + (adjusted_price * precond_increases)
		adjusted_price - gender_discount
	end

	def precond_increases
		conditions.reduce(0.0) do |total,condition|
			total += health_conditions.fetch(condition.downcase,0)
			total
		end
	end

	def gender_discount
		female? ? 12 : 0
	end

	def age_based_price_inc
		20
	end

	def location_discount
		east_coast? ? 0.05 : 0
	end

	def east_coast?
		["Boston", "New York"].include?(location)
	end

	def female?
		gender == "female"
	end

	def minimum_age_eligibility
		18
	end

	def health_conditions
		{
			'allergies' => 0.01,
			'sleep apnea' => 0.06,
			'heart disease' => 0.17,
			'high cholesterol' => 0.08,
			'asthma' => 0.04,
			'n/a' => 0.0
		}
	end
end
