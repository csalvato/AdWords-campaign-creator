class BingAd
	# Max Field Lengths (in characters)
	MAX_AD_TITLE_LENGTH = 25
	MAX_AD_TEXT_LENGTH = 71
	MAX_AD_DISPLAY_URL_LENGTH = 35
	MAX_AD_DESTINATION_URL_LENGTH = 1024
	TYPE_STRING = "Text Ad"

	def initialize( opts={} )
		opts = { campaign: nil,
		  ad_group: nil,
		  title: "",
		  text: "",
		  display_url: "",
		  destination_url: "",
		  device_preference: "All",
		  status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@title = opts[:title]
		@text = opts[:text]
		@display_url = opts[:display_url]
		@destination_url = opts[:destination_url]
		@device_preference = opts[:device_preference]
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
			when "Title"
				output_row << @title
			when "Text"
				output_row << @text
			when "Display URL"
				output_row << @display_url
			when "Destination URL"
				output_row << @destination_url
			when "Device Preference"
				output_row << @device_preference
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		return output_row
	end
end