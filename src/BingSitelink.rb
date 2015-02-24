class BingSitelink
	TYPE_STRING_CAMPAIGN_SITELINK = "Campaign Sitelink Ad Extension"
	TYPE_STRING_SITELINK = "Sitelink Ad Extension"
	MAX_LINK_TEXT_LENGTH = 25
	MAX_DESCRIPTION_LENGTH = 35
	MAX_DISPLAY_URL_LENGTH = 1024

	def initialize( opts={} )
		opts = {campaign: nil,
				id: 0,
				desc_line_1: "",
				desc_line_2: "",
				destination_url: "",
				link_text: "",
				status: "Active",
				order_number: 0
			}.merge(opts)
		@campaign = opts[:campaign]
		@id = opts[:id]
		@desc_line_1 = opts[:desc_line_1]
		@desc_line_2 = opts[:desc_line_2]
		@destination_url = opts[:destination_url]
		@link_text = opts[:link_text]
		@status = opts[:status]
		@order_number = opts[:order_number]
	end

	def formatVersionRow # Required for sitelink imports to work.
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << "Format Version"
			when "Name"
				output_row << "3"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end

	def sharedSettingRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING_CAMPAIGN_SITELINK
			when "ID"
				output_row << @id
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end

	def settingsRow
		output_row = []
		
		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING_SITELINK
			when "ID"
				output_row << @id
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			when "Sitelink Extension Order"
				output_row << @order_number.to_s
			when "Sitelink Extension Link Text"
				output_row << @link_text
			when "Sitelink Extension Destination URL"
				output_row << @destination_url
			when "Sitelink Extension Description1"
				output_row << @desc_line_1
			when "Sitelink Extension Description2"
				output_row << @desc_line_2
			when "Device Preference"
				output_row << "All"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end