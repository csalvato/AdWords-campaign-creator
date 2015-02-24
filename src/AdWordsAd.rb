class Ad
	MAX_AD_HEADLINE_LENGTH = 25
	MAX_AD_DESCRIPTION_LENGTH = 35
	MAX_AD_DISPLAY_URL_LENGTH = 35
	MAX_AD_DESTINATION_URL_LENGTH = 1024

	def initialize( opts={} )
		opts = { campaign: nil,
		  ad_group: nil,
		  headline: "",
		  desc_line_1: "",
		  desc_line_2: "",
		  display_url: "",
		  destination_url: "",
		  device_preference: "All",
		  status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@headline = opts[:headline]
		@desc_line_1 = opts[:desc_line_1]
		@desc_line_2 = opts[:desc_line_2]
		@display_url = opts[:display_url]
		@destination_url = opts[:destination_url]
		@device_preference = opts[:device_preference]
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
			when "Headline"
				output_row << @headline
			when "Description Line 1"
				output_row << @desc_line_1
			when "Description Line 2"
				output_row << @desc_line_2
			when "Display URL"
				output_row << @display_url
			when "Destination URL"
				output_row << @destination_url
			when "Device Preference"
				output_row << @device_preference
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