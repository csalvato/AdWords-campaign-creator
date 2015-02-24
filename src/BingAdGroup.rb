
class BingAdGroup
	attr_accessor :ads, :keywords, :name
	TYPE_STRING = "Ad Group"

	def initialize( opts={} )
		opts = { campaign: nil, 
				 name: "Default AdGroup Name", 
				 keywords: Array[], 
				 ads: Array[], 
				 status: "Active"}.merge(opts)

		@campaign = opts[:campaign]
		@name = opts[:name]
		@keywords = opts[:keywords]
		@ads = opts[:ads]
		@status = opts[:status]
	end

	def createKeyword(keywordString)
		# Create ad group object
		@keywords << BingKeyword.new( campaign: @campaign,
		 		 				  ad_group: self,
						 		  keyword: keywordString)
	end

	# => createAds - creates ad objects for the campaign based on seed keywords
	def	createAd(title, text, display_url, destination_url, device_preference)
		@ads << BingAd.new( campaign: @campaign,
						ad_group: self,
						title: title,
						text: text,
						display_url: display_url,
						destination_url: destination_url,
						device_preference: device_preference )
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
				output_row << @name
			when "Start Date"
				output_row << @start_date
			when "Search Network"
				output_row << "on"
			when "Content Network"
				output_row << "off"
			when "Network Distribution"
				output_row << "OwnedAndOperatedAndSyndicatedSearch"
			when "Search Bid"
				output_row << "0.05"
			when "Content Bid"
				output_row << "0.05"
			when "Language"
				output_row << "English"
			when "Ad Rotation"
				output_row << "OptimizeForClicks"
			when "Pricing Model"
				output_row << "Cpc"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end