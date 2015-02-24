class BingKeyword
	TYPE_STRING = "Keyword"

	def initialize( opts={} )
		opts = { campaign: nil,
		 		 ad_group: nil,
		 		 bid: 0.50,
		 		 keyword: "",
		 		 match_type: "Broad",
		 		 device: "All",
		 		 status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@bid = opts[:bid]
		@keyword = opts[:keyword]
		@match_type = opts[:match_type]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @ad_group.name
			when "Keyword"
				output_row << @keyword
			when "Match Type"
				output_row << @match_type
			when "Bid"
				output_row << @bid
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		return output_row
	end
end