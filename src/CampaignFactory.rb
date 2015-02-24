class CampaignFactory
	def initialize(opts={})	
	end

	def selectOptionOfLength (options_array, max_length)
		options_array.each do |option|
			if option.length <= max_length
				return option
			end 
		end

		error_message = "ERROR: None Under " + max_length.to_s + " Characters!"
		puts error_message
		return error_message
	end
end