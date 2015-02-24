class Campaign
	attr_accessor :output_row_headers, :status, :name
	MAX_ADGROUPS_PER_CAMPAIGN = 20000

	def initialize(opts={})
		opts = {name: "Default Name",
				daily_budget: "10",
				networks: "Search Partners",
				languages: "en",
				bid_strategy_type: "Manual CPC",
				enhanced_cpc: "Disabled",
				viewable_cpm: "Disabled",
				bid_modifier: "-100",
				start_date: Time.now.strftime("%m-%d-%Y"),
				end_date: "[]",
				ad_schedule: "[]",
				location: "United States",
				campaign_status: "Active",
				status: "Active",
				sitelinks: [],
				adgroups: [] }.merge(opts)
		@name = opts[:name]
		@daily_budget = opts[:daily_budget]
		@networks = opts[:networks]
		@languages = opts[:languages]
		@bid_strategy_type = opts[:bid_strategy_type]
		@enhanced_cpc = opts[:enhanced_cpc]
		@viewable_cpm = opts[:viewable_cpm]
		@bid_modifier = opts[:bid_modifier]
		@start_date = opts[:start_date]
		@end_date = opts[:end_date]
		@ad_schedule = opts[:ad_schedule]
		@location = opts[:location]
		@campaign_status = opts[:campaign_status]
		@status = opts[:status]
		@sitelinks = opts[:sitelinks]
		@adgroups = opts[:adgroups]

		@output_row_headers = [ "Campaign",
								"Campaign Daily Budget",
								"Campaign Type",
								"Networks",
								"Languages",
								"Location",
								"Ad Group",
								"Max CPC",
								"Display Network Max CPC",
								"Max CPM",
								"CPA Bid",
								"Display Network Custom Bid Type",
								"Ad Group Type",
								"Flexible Reach",
								"Keyword",
								"ID",
								"Criterion Type",
								"Bid Strategy Type",
								"Bid Strategy Name",
								"Enhanced CPC",
								"Viewable CPM",
								"Bid Modifier",
								"Link Text",
								"Headline",
								"Description Line 1",
								"Description Line 2",
								"App ID / Package name",
								"Display URL",
								"Destination URL",
								"Platform Targeting",
								"Device Preference",
								"Start Date",
								"End Date",
								"Ad Schedule",
								"Campaign Status",
								"AdGroup Status",
								"Status"]
	end

	def createAdGroup(name)
		# Create ad group object
		new_ad_group = AdGroup.new( name: name, 
								  campaign: self)
		@adgroups <<  new_ad_group
		return new_ad_group
	end

	def createSitelink(link_text, desc_line_1, desc_line_2, destination_url)
		@sitelinks << Sitelink.new( campaign: self,
									desc_line_1: desc_line_1,
									desc_line_2: desc_line_2,
									destination_url: destination_url,
									link_text: link_text
									)
	end 

	# Set first to true if it is the first campaign in a set of campaigns that need to be in the same file.
	def outputCampaign(output_filename, first)

		write_options = "wb" if first
		write_options = "a" if not first

		CSV.open(output_filename, write_options, {:encoding => "utf-8", force_quotes: false }) do |csv|
			# Create Headers
			csv << @output_row_headers if first
			# Output Campaign Settings Row
			csv << self.settingsRow

			# Output location row (this must be it's own row for 
			# Mobile Bid adjustment to work in campaign settings row)
			csv << self.locationRow

			# Output All AdGroups Settings Rows
			@adgroups.each do |adgroup|
			 	csv << adgroup.settingsRow
			 	adgroup.keywords.each do |keyword|
			 		csv << keyword.settingsRow
			 	end
			 	adgroup.ads.each do |ad|
			 		csv << ad.settingsRow
			 	end
			end

			# Output All Sitelinks Settings Rows
			@sitelinks.each do |sitelink|
				csv << sitelink.settingsRow
			end

		end
	end

	# Output the location row as an array.
	def locationRow
		output_row = []

		@output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @name
			when "Location"
				output_row << @location
			when "ID"
				output_row << "2840" # AdWords ID code for "United States" location
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end

	# Outputs the settings row as an array
	def settingsRow
		output_row = []
		
		@output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @name
			when "Campaign Daily Budget"
				output_row << @daily_budget
			when "Languages"
				output_row << @languages
			when "Networks"
				output_row << @networks 
			when "Status"
				output_row << @status
			when "Bid Strategy Type"
				output_row << @bid_strategy_type				
			when "Enhanced CPC"
				output_row << @enhanced_cpc
			when "Viewable CPM"
				output_row << @viewable_cpm
			when "Bid Modifier"
				output_row << @bid_modifier
			when "Start Date"
				output_row << @start_date
			when "End Date"
				output_row << @end_date
			when "Ad Schedule"
				output_row << @ad_schedule
			when "Campaign Status"
				output_row << @campaign_status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end