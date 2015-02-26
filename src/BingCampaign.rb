class BingCampaign
	attr_accessor :output_row_headers, :name, :id_for_sitelinks, :mobile_bid_adjustment, :tablet_bid_adjustment
	MAX_ADGROUPS_PER_CAMPAIGN = 20000
	TYPE_STRING = "Campaign"

	def initialize(opts={})
		opts = {name: "Default Name",
				budget: "10",
				mobile_bid_adjustment: 0,
				tablet_bid_adjustment: 0,
				computers_bid_adjustment: 0,
				status: "Active",
				sitelinks: [],
				adgroups: [],
				id_for_sitelinks: 0,
				location: "United States",
				location_id: "190" }.merge(opts)

		@name = opts[:name]
		@budget = opts[:budget]
		@status = opts[:status]
		@sitelinks = opts[:sitelinks]
		@adgroups = opts[:adgroups]
		@mobile_bid_adjustment = opts[:mobile_bid_adjustment] 
		@tablet_bid_adjustment = opts[:tablet_bid_adjustment]
		@computers_bid_adjustment = opts[:computers_bid_adjustment]
		@id_for_sitelinks = opts[:id_for_sitelinks]
		@location = opts[:location]
		@location_id = opts[:location_id]

		@output_row_headers = [ "Type",
								"ID",
								"Status",
								"Campaign",
								"Budget",
								"Budget Type",
								"Ad Group",
								"Keyword",
								"Match Type",
								"Bid",
								"Title",
								"Text",
								"Display URL",
								"Destination URL",
								"Time Zone",
								"Keyword Variant Match Type Enabled",
								"Start Date",
								"Search Network",
								"Content Network",
								"Network Distribution",
								"Search Bid",
								"Content Bid",
								"Language",
								"Ad Rotation",
								"Pricing Model",
								"Negative",
								"Target",
								"Physical Intent",
								"Bid Adjustment",
								"Sitelink Extension Order",
								"Sitelink Extension Link Text",
								"Sitelink Extension Destination URL",
								"Sitelink Extension Description1",
								"Sitelink Extension Description2",
								"Name",
								"Device Preference"]
	end

def self.location_data(location_code)
		location_data = {"AL" => {code: "US-AL",
												      name: "Alabama",
												      id: "4080" },
										"AK" => {code: "US-AK",
										       name: "Alaska",
										       id: "4079" },
										"AZ" => {code: "US-AZ",
										       name: "Arizona",
										       id: "4083" },
										"AR" => {code: "US-AR",
										       name: "Arkansas",
										       id: "4081" },
										"CA" => {code: "US-CA",
										       name: "California",
										       id: "4084" },
										"CO" => {code: "US-CO",
										       name: "Colorado",
										       id: "4085" },
										"CT" => {code: "US-CT",
										       name: "Connecticut",
										       id: "4086" },
										"DE" => {code: "US-DE",
										       name: "Delaware",
										       id: "4088" },
										"FL" => {code: "US-FL",
										       name: "Florida",
										       id: "4089" },
										"GA" => {code: "US-GA",
										       name: "Georgia",
										       id: "4090" },
										"HI" => {code: "US-HI",
										       name: "Hawaii",
										       id: "4092" },
										"ID" => {code: "US-ID",
										       name: "Idaho",
										       id: "4094" },
										"IL" => {code: "US-IL",
										       name: "Illinois",
										       id: "4095" },
										"IN" => {code: "US-IN",
										       name: "Indiana",
										       id: "4096" },
										"IA" => {code: "US-IA",
										       name: "Iowa",
										       id: "4093" },
										"KS" => {code: "US-KS",
										       name: "Kansas",
										       id: "4097" },
										"KY" => {code: "US-KY",
										       name: "Kentucky",
										       id: "4098" },
										"LA" => {code: "US-LA",
										       name: "Louisiana",
										       id: "4099" },
										"ME" => {code: "US-ME",
										       name: "Maine",
										       id: "4102" },
										"MD" => {code: "US-MD",
										       name: "Maryland",
										       id: "4101" },
										"MA" => {code: "US-MA",
										       name: "Massachusetts",
										       id: "4100" },
										"MI" => {code: "US-MI",
										       name: "Michigan",
										       id: "4103" },
										"MN" => {code: "US-MN",
										       name: "Minnesota",
										       id: "4104" },
										"MS" => {code: "US-MS",
										       name: "Mississippi",
										       id: "4107" },
										"MO" => {code: "US-MO",
										       name: "Missouri",
										       id: "4105" },
										"MT" => {code: "US-MT",
										       name: "Montana",
										       id: "4108" },
										"NE" => {code: "US-NE",
										       name: "Nebraska",
										       id: "4111" },
										"NV" => {code: "US-NV",
										       name: "Nevada",
										       id: "4115" },
										"NH" => {code: "US-NH",
										       name: "New Hampshire",
										       id: "4112" },
										"NJ" => {code: "US-NJ",
										       name: "New Jersey",
										       id: "4113" },
										"NM" => {code: "US-NM",
										       name: "New Mexico",
										       id: "4114" },
										"NY" => {code: "US-NY",
										       name: "New York",
										       id: "4116" },
										"NC" => {code: "US-NC",
										       name: "North Carolina",
										       id: "4109" },
										"ND" => {code: "US-ND",
										       name: "North Dakota",
										       id: "4110" },
										"OH" => {code: "US-OH",
										       name: "Ohio",
										       id: "4117" },
										"OK" => {code: "US-OK",
										       name: "Oklahoma",
										       id: "4118" },
										"OR" => {code: "US-OR",
										       name: "Oregon",
										       id: "4119" },
										"PA" => {code: "US-PA",
										       name: "Pennsylvania",
										       id: "4120" },
										"RI" => {code: "US-RI",
										       name: "Rhode Island",
										       id: "4122" },
										"SC" => {code: "US-SC",
										       name: "South Carolina",
										       id: "4123" },
										"SD" => {code: "US-SD",
										       name: "South Dakota",
										       id: "4124" },
										"TN" => {code: "US-TN",
										       name: "Tennessee",
										       id: "4125" },
										"TX" => {code: "US-TX",
										       name: "Texas",
										       id: "4126" },
										"US" => {code: "US",
										       name: "United States",
										       id: "190" },
										"UT" => {code: "US-UT",
										       name: "Utah",
										       id: "4128" },
										"VT" => {code: "US-VT",
										       name: "Vermont",
										       id: "4131" },
										"VA" => {code: "US-VA",
										       name: "Virginia",
										       id: "4129" },
										"WA" => {code: "US-WA",
										       name: "Washington",
										       id: "4132" },
										"WV" => {code: "US-WV",
										       name: "West Virginia",
										       id: "4134" },
										"WI" => {code: "US-WI",
										       name: "Wisconsin",
										       id: "4133" },
										"WY" => {code: "US-WY",
										       name: "Wyoming",
										       id: "4135" }
										}

		location_data[location_code]
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
			bid_adjustment_rows = self.bidAdjustmentRows
			bid_adjustment_rows.each do |bid_adjustment_row|
				csv << bid_adjustment_row
			end

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
			@sitelinks.each_with_index do |sitelink, index|
				csv << sitelink.formatVersionRow if index == 0 # Required row by bing to make sure sitelinks work
				csv << sitelink.sharedSettingRow if index == 0 # Required row by bing to tie sitelinks to a campaign
				csv << sitelink.settingsRow
			end

		end
	end

	def createAdGroup(name)
		# Create ad group object
		new_ad_group = BingAdGroup.new( name: name, 
								  campaign: self)
		@adgroups <<  new_ad_group
		return new_ad_group
	end

	def createSitelink(link_text, desc_line_1, desc_line_2, destination_url, id, order_number)
		@sitelinks << BingSitelink.new( campaign: self,
									id: id,
									desc_line_1: desc_line_1,
									desc_line_2: desc_line_2,
									destination_url: destination_url,
									link_text: link_text,
									order_number: order_number )
	end 

	# Output the location row as an array.
	def bidAdjustmentRows
		output_rows = []

		adjustment_types = ["Campaign Location Target", "Campaign DeviceOS Target"]
		
		adjustment_types.each do |adjustment_type|

			if adjustment_type == "Campaign Location Target"
				target = @location
				adjustment_in_percentage = 0
				output_rows << bidAdjustmentRow(adjustment_type, target, adjustment_in_percentage)
			elsif adjustment_type == "Campaign DeviceOS Target"
				device_adjustments = { 'Smartphones' => @mobile_bid_adjustment, 
									   'Tablets' => @tablet_bid_adjustment, 
									   'Computers' => @computers_bid_adjustment }
				device_adjustments.each do |target, adjustment_in_percentage|
					output_rows << bidAdjustmentRow(adjustment_type, target, adjustment_in_percentage)
				end
			end
		end
		
		output_rows
	end

	# Output the location row as an array.
	def bidAdjustmentRow(adjustment_type, target, adjustment_in_percentage)
		output_row = []

		@output_row_headers.each do |header|
			case header
			when "Type"
				# adjustment_type = "Campaign Location Target" for location
				# adjustment_type = "Campaign DeviceOS Target" for device
				output_row << adjustment_type
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @name
			when "Target"
				# target = "US" for United states location target
				# target = "Smartphones" for DeviceOS Target to Mobile Phones
				# target = "Tablets" for DeviceOS Target to Tablets
				# target = "Computers" for DeviceOS Target to Computers
				output_row << target
			when "Physical Intent"
				output_row << "PeopleInOrSearchingForOrViewingPages"
			when "Bid Adjustment"
				output_row << adjustment_in_percentage
			when "Name"
				output_row << "United States"
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
			when "Type"
				output_row << TYPE_STRING
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @name
			when "Budget"
				output_row << @budget 
			when "Budget Type"
				output_row << "DailyBudgetAccelerated"
			when "Time Zone"
				output_row << "PacificTimeUSCanadaTijuana"				
			when "Keyword Variant Match Type Enabled"
				output_row << "TRUE"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end