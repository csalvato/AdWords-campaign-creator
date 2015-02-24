class Sitelink
	MAX_LINK_TEXT_LENGTH = 25
	MAX_DESCRIPTION_LENGTH = 35
	MAX_DISPLAY_URL_LENGTH = 2048

	def initialize( opts={} )
		opts = {campaign: nil, 
				desc_line_1: "",
				desc_line_2: "",
				destination_url: "",
				link_text: "",
				status: "Active"
			}.merge(opts)
		@campaign = opts[:campaign]
		@desc_line_1 = opts[:desc_line_1]
		@desc_line_2 = opts[:desc_line_2]
		@destination_url = opts[:destination_url]
		@link_text = opts[:link_text]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []
		
		@campaign.output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign.name
			when "Start Date"
				output_row << "[]"
			when "End Date"
				output_row << "[]"
			when "Ad Schedule"
				output_row << "[]"
			when "Description Line 1"
				output_row << @desc_line_1
			when "Description Line 2"
				output_row << @desc_line_2
			when "Destination URL"
				output_row << @destination_url
			when "Device Preference"
				output_row << "All"
			when "Link Text"
				output_row << @link_text
			when "Feed Name"
				output_row << "Main sitelink feed"
			when "Platform Targeting"
				output_row << "All"
			when "Campaign Status"	
				output_row << @campaign.status
			when "Status"
				output_row << @status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end