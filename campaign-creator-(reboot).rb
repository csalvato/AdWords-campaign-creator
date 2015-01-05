# Create campaign CSV files
# This script first creates a campaign object with seed keywords.  
# Then, the campaign object creates AdGroup objects to fit the advertising strategy we are pioneering, 
# which, in turn, create the Keywords and Ads objects to be stored within each ad group.
# The campaign object then owns the Ad Group object, and, by proxy, the Ads and Keywords objects.
# It can call "createCompleteCampaign" to output the necessary CSV file.
# In the future, additional output methods can be created to fit different advertising schemes, 
# using the same cascade of creating ad groups that create their own keywords.

start_time = Time.now
puts "Starting Script..."

require 'csv'

# Class representing a "Campaign Factory" that can make different kinds of campaigns
class CampaignFactory

	def initialize(opts={})
	end

	def createModifiedBroadCityStateCampaign(seed, short_seed, niche, landingPage, area_of_study, concentration)
		campaign_name = "IP=US [#{niche}] {#{seed} +SUBLOCATION +LOCATIONCODE} (search; modbroad)"
		campaign = Campaign.new( name: campaign_name )

		# Set some initial variables
		city = "City"
		state_name = "State"
		state_code = "ST"
		location = state_name
		sublocation = city
		locationcode = state_code
		page_headline = "Looking for " + seed + " in " + city + ", " + state_code + "?"
		sitelink_utm_campaign = "_src*adwords_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
		sitelink_destination_url = "http://koodlu.com/#{landingPage}/" +
									"?area_of_study=#{area_of_study}" + 
									"&concentration=#{concentration}" +
									"&seed=#{seed.gsub(" ", "%20")}" +
									"&headline=#{page_headline.gsub(" ","%20").gsub("?","%3f")}" +
									"&utm_campaign=#{sitelink_utm_campaign}" +
									"&utm_source=Google" +
									"&utm_medium=cpc"

		createCityStateSitelink1(campaign, niche, seed, short_seed, sitelink_destination_url)
		createCityStateSitelink2(campaign, niche, seed, short_seed, sitelink_destination_url)
		createCityStateSitelink3(campaign, niche, seed, short_seed, sitelink_destination_url)
		createCityStateSitelink4(campaign, niche, seed, short_seed, sitelink_destination_url)

		ad_group_name = seed + " in " + city + " " + state_code
		adgroup = campaign.createAdGroup(ad_group_name)

		keywordString = "+" + (seed + city + state_code).gsub(" ", " +")
		adgroup.createKeyword(keywordString)


		device_preferences = ["All", "Mobile"]
		device_preferences.each do |device_preference|
			if device_preference == "Mobile"
				device_code = "mb" 			
			else
				device_code = "dt"
			end
			utm_campaign = "_src*adwords_d*{ifmobile:mb}{ifnotmobile:dt}_d2*#{device_code}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
			destination_url = "http://koodlu.com/#{landingPage}/" +
							  "?area_of_study=#{area_of_study}" +
							  "&concentration=#{concentration}" + 
							  "&seed=#{seed.gsub(" ", "%20")}" + 
							  "&location=#{location}" + 
							  "&sublocation=#{sublocation.gsub(" ","%20")}" + 
							  "&locationcode=#{locationcode}" + 
							  "&headline=#{page_headline.gsub(" ","%20")}" + 
							  "&utm_campaign=#{utm_campaign}" + 
							  "&utm_source=Google" + 
							  "&utm_medium=cpc"
			createCityStateAd(adgroup, niche, seed, short_seed, city, state_name, state_code, destination_url, device_preference)
		end

		return campaign
	end

	def selectOptionOfLength (options_array, max_length)
		options_array.each do |option|
			if option.length <= max_length
				return option
			end 
		end

		return "ERROR: None Under " + max_length.to_s + " Characters!"
	end

	def createCityStateAd(adgroup, niche, seed, short_seed, city, state_name, state_code, destination_url, device_preference)
		headline_options = [seed + " " + city + " " + state_code,
							seed + " " + city,
							seed + " " + state_name,
							seed + " " + state_code,
							seed,
							short_seed + " " + city + " " + state_code,
							short_seed + " " + city,
							short_seed + " " + state_name,
							short_seed + " " + state_code,
							short_seed]
		headline = selectOptionOfLength( headline_options, 25 )
		
		desc_line_1_options = [city + " " + seed + " " + state_name + "?",
							   city + " " + seed + " " + state_code + "?",
							   city + " " + seed + "?",
							   state_name + " " + seed + "?",
							   state_code + " " + seed + "?",
							   seed + "?",
							   city + " " + short_seed + " " + state_name + "?",
							   city + " " + short_seed + " " + state_code + "?",
							   city + " " + short_seed + "?",
							   state_name + " " + short_seed + "?",
							   state_code + " " + short_seed + "?",
							   short_seed + "?",]
		desc_line_1 = selectOptionOfLength( desc_line_1_options, 35 )

		desc_line_2_options  = ["Find " + city + " " + seed,
								"Find " + state_name + " " + seed,
							    "Find " + state_code + " " + seed,
								"Find " + seed,
								seed,
								"Find " + city + " " + short_seed,
								"Find " + state_name + " " + short_seed,
							    "Find " + state_code + " " + short_seed,
								"Find " + short_seed,
								short_seed]
		desc_line_2 = selectOptionOfLength( desc_line_2_options, 35 )


		display_url_options = [ seed.gsub(" ","-") + ".koodlu.com/" + city,
								seed.gsub(" ","-") + ".koodlu.com/" + state_name,
								seed.gsub(" ","-") + ".koodlu.com/" + state_code,
								seed.gsub(" ","-") + ".koodlu.com",
								niche.gsub(" ","-") + ".koodlu.com/" + city,
								niche.gsub(" ","-") + ".koodlu.com/" + state_name,
								niche.gsub(" ","-") + ".koodlu.com/" + state_code,
								niche.gsub(" ","-") + ".koodlu.com",
								short_seed.gsub(" ","-") + ".koodlu.com/" + city,
								short_seed.gsub(" ","-") + ".koodlu.com/" + state_name,
								short_seed.gsub(" ","-") + ".koodlu.com/" + state_code,
								short_seed.gsub(" ","-") + ".koodlu.com",]
		display_url = selectOptionOfLength( display_url_options, 35 )

		adgroup.createAd(headline, desc_line_1, desc_line_2, display_url, destination_url, device_preference)
	end

	def createCityStateSitelink1(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Find " + seed + " Near You",
							  		  seed + " Near You",
							          "Find " + seed,
							      	  seed,
							      	  "Find " + short_seed + " Near You",
							  		  short_seed + " Near You",
							          "Find " + short_seed,
							      	  short_seed,
							      	  "Find " + niche + " Training",
							      	  niche + " Training"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, 25 )
		
		sitelink_desc_line_1_options = ["Looking for " + seed + "?",
										"Need " + seed + "?",
										seed + "?",
										"Looking for " + short_seed + "?",
										"Need " + short_seed + "?",
										short_seed + "?",
										"Looking for " + niche + "Classes?",
										"Need " + niche + "?",
										niche + " Classes?"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, 35 )

		sitelink_desc_line_2_options = ["Find " + seed + " Now",
										"Find " + short_seed + " Now",
										seed + " Now",
										short_seed + " Now",
										niche + " Training Now",
										"Quick Training Finder"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, 35 )

		url = sitelink_destination_url + "&sitelink-test=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end

	def createCityStateSitelink2(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Quick " + seed + " Finder",
							  		  seed + " Finder",
							  		  "Quick" + short_seed + " Finder",
							          niche + " Classes Finder",
							      	  seed,
							      	  short_seed + " Finder"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, 25 )
		
		sitelink_desc_line_1_options = ["Use our " + seed + " Finder",
										"Use " + seed + " Finder",
										"Use our " + short_seed + " Finder",
										"Use " + short_seed + " Finder",
										"Use " + niche + " Classes Finder",
										"Use Our Classes Finder"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, 35 )

		sitelink_desc_line_2_options = ["To Find " + seed + " Now",
										"To Find " + seed,
										"To Find " + short_seed + " Now",
										"To Find " + seed,
										"To Find " + niche + " Classes Now",
										"To Find " + niche + " Classes",
										"To Find Classes Now"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, 35 )

		url = sitelink_destination_url + "&sitelink-test=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end

	def createCityStateSitelink3(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Submit Your Info Online"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, 25 )
		
		sitelink_desc_line_1_options = ["Take 60 Seconds To Submit Your Info"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, 35 )

		sitelink_desc_line_2_options = ["To Find " + seed + " Now",
										"To Find " + seed,
										"To Find " + short_seed + " Now",
										"To Find " + seed,
										"To Find " + niche + " Classes Now",
										"To Find " + niche + " Classes",
										"To Find Classes Now"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, 35 )

		url = sitelink_destination_url + "&sitelink-test=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end

	def createCityStateSitelink4(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Takes Less Than 1 Min"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, 25 )
		
		sitelink_desc_line_1_options = ["Find " + seed + " Fast",
										"Find " + seed,
										"Find " + short_seed + " Fast",
										"Find " + short_seed,
										"Find Classes Fast"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, 35 )

		sitelink_desc_line_2_options = ["Using Our " + seed + " Search",
										"Using " + seed + " Search",
										seed + " Search",
										"Using Our " + short_seed + " Search",
										"Using " + short_seed + " Search",
										short_seed + " Search",
										"Using Our " + niche + " Classes Search",
										"Using " + niche + " Classes Search",
										niche + " Classes Search"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, 35 )

		url = sitelink_destination_url + "&sitelink-test=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end
end

# Class representing a campaign
	# Properties:
		# => campaign_name (string - "IP={US}Modbroad, blah blah")
		# => daily_budget (float - 10.00)
		# => languages (string - "en")
		# => networks (string - "Google Search" [does this specify partners, too?])
		# => Status (string - "enabled")
		# => seeds (Array of strings of human readable seed keywords)
	# Methods:
		# => outputModifiedBroadCampaignFromSeeds (outputs a CSV file of the complete campaign data ready for importing)
		# => outputSettingsRow (outputs the settings row for the campaign as ready for campaign import CSV)
		# => createAdGroup - creates ad group object for the campaign based on seed keywords
class Campaign
	attr_accessor :output_row_headers, :status, :name

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

	def outputCampaign(output_filename)

		CSV.open(output_filename, "wb", {:encoding => "utf-8", force_quotes: false }) do |csv|
			# Create Headers
			csv << @output_row_headers
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

class Sitelink
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

# Class representing an Ad Group (a group of keywords)
	# Properties:
		# => campaign (Campaign object this ad group belongs to)
		# => keywords (Array of objects of Keyword Class)
		# => ads (Arry of objects of Ad class
		# => ad_group_status (string - "Enabled")
	# Methods:
		# => outputSettingsRow (outputs the settings row for the Ad Group as ready for campaign import CSV)

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

# Class representing a Keyword	
	# Properties:
		# => Campaign (Campaign object this keyword belongs to)
		# => ad_group (Ad Group object this belongs to)
		# => max_cpc (float - 0.50)
		# => keyword (string - "[CNA Classes Online]")
		# => type - (string - "Broad")
		# => device preference (string - "All")
	# Methods:
		# => outputSettingsRow (outputs the settings row for the Ad Group as ready for campaign import CSV)
class Keyword
	def initialize( opts={} )
		opts = { campaign: nil,
		 		 ad_group: nil,
		 		 max_cpc: 0.50,
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

# Class representing an Ad
	# Properties:
		# => Campaign (Campaign object this ad belongs to)
		# => Ad Group (Ad Group object this belongs to)
		# => headline (string - max length 25)
		# => desc_line_1 (string - max length 35)
		# => desc_line_2 (string - max length 35)
		# => display_url (string - max length 35)
		# => destination_url (string)
		# => Device Preference (string - "All")
	# Methods:
		# => outputSettingsRow (outputs the settings row for the Ad Group as ready for campaign import CSV)
class Ad
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

#Create Campaign Factory to help with campaign creation
campaignFactory = CampaignFactory.new()

#Set Niche Parameters
seed = "Human Resources Certification"
short_seed = "HR Certification"
niche = "Human Resources"
landingPage = "human-resources0"
areaOfStudy = "6B5B6155"
concentration = "01855C0C"

#Create Mod Broad City-State Campaign using Niche Parameters
campaign = campaignFactory.createModifiedBroadCityStateCampaign(seed, short_seed, niche, landingPage, areaOfStudy, concentration)

#Output the campaign as a CSV
output_filename = "campaign-for-import.csv"
campaign.outputCampaign(output_filename)

puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"