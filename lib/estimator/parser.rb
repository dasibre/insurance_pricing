data = [
	     ["first_name","Age","Gender","Location", "Health Conditions"],
	     ["Brad", "20", "male", "San Francisco", "n/a"],
	     ["Stan", "10", "male", "San Francisco", "Asthma"]
       ]

module TableDataParse
	def my_hash(tabular_data)
		result = []
		data = tabular_data.clone
		header = data.shift
		data.map do |row|
			h = {}
			row.each_with_index do |_, idx|
				h[header[idx].downcase.tr(" ","_")] = row[idx]
			end
			h
		end
	end
end
