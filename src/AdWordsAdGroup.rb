class AdGroup
	attr_accessor :ads, :keywords, :name, :ad_group_status

	def initialize( opts={} )
		opts = { campaign: nil, 
				 name: "Default AdGroup Name", 
				 keywords: Array[], 
				 ads: Array[], 
				 ad_group_status: "Active"}.merge(opts)

		@campaign = opts[:campaign]
		@name = opts[:name]
		@keywords = opts[:keywords]
		@ads = opts[:ads]
		@ad_group_status = opts[:ad_group_status]
	end

	def createKeyword(keywordString)
		# Create ad group object
		@keywords << Keyword.new( campaign: @campaign,
		 		 				  ad_group: self,
						 		  keyword: keywordString)
	end

	# => createAds - creates ad objects for the campaign based on seed keywords
	def	createAd(headline, desc_line_1, desc_line_2, display_url, destination_url, device_preference)
		@ads << Ad.new( campaign: @campaign,
						ad_group: self,
						headline: headline,
						desc_line_1: desc_line_1,
						desc_line_2: desc_line_2,
						display_url: display_url,
						destination_url: destination_url,
						device_preference: device_preference,
						status: "Active")
	end

	def settingsRow
		output_row = []
		
		@campaign.output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @name
			when "Max CPC"
				output_row << "0.01"
			when "Display Network Max CPC"
				output_row << "0"
			when "Max CPM"
				output_row << "0.25"
			when "CPA Bid"
				output_row << "0.01"
			when "Display Network Custom Bid Type"
				output_row << "None"
			when "Ad Group Type"
				output_row << "Default"
			when "Flexible Reach"
				output_row << "Interests and remarketing"
			when "Campaign Status"
				output_row << @campaign.status
			when "AdGroup Status"
				output_row << @ad_group_status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end