class Keyword
	def initialize( opts={} )
		opts = { campaign: nil,
		 		 ad_group: nil,
		 		 max_cpc: 1.00,
		 		 keyword: "",
		 		 type: "Broad",
		 		 device: "All",
		 		 status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@max_cpc = opts[:max_cpc]
		@keyword = opts[:keyword]
		@type = opts[:type]
		@device = opts[:device]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @ad_group.name
			when "Max CPC"
				output_row << @max_cpc
			when "Keyword"
				output_row << @keyword
			when "Criterion Type"
				output_row << @type
			when "Campaign Status"
				output_row << @campaign.status
			when "AdGroup Status"
				output_row << @ad_group.ad_group_status
			when "Status"
				output_row << @status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		return output_row
	end
end