class Person
	attr_accessor :name, :age, :gender, :location, :condition

	def initialize(attrs = {})
		attrs.each { |key, value| send "#{key}=", value }
	end
end

describe Person do
	let(:attrs) { {name: 'jane', age: '20', gender: "female", location: "New York", condition: "Asthma"} }
	
	subject { Person.new(attrs) }

	it { is_expected.to respond_to(:name)}
	it { is_expected.to respond_to(:age)}
	it { is_expected.to respond_to(:gender)}
	it { is_expected.to respond_to(:location)}
	it { is_expected.to respond_to(:condition)}
end