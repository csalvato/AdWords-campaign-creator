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

	def createModifiedBroadCityStateCampaign(seed, niche, landingPage, areaOfStudy, concentration)
		campaign_name = "IP=US [#{niche}] {#{seed} +SUBLOCATION +LOCATIONCODE} (search; modbroad)"
		campaign = Campaign.new( name: campaign_name )

		ad_group_name = seed + " in " + "City" + " " + "State"

		adgroup = campaign.createAdGroup(ad_group_name)

		keywordString = "+" + seed.gsub(" ", " +")
		keyword = adgroup.createKeyword(keywordString)

		return campaign
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
								"Sitelink Text",
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

	def outputCampaign(output_filename)

		CSV.open(output_filename, "wb", {:encoding => "utf-8", force_quotes: false }) do |csv|
			# Create Headers
			csv << @output_row_headers
			# Output Campaign Settings Row
			csv << self.settingsRow

			# Output All AdGroups Settings Rows
			@adgroups.each do |adgroup|
			 	csv << adgroup.settingsRow
			 	adgroup.keywords.each do |keyword|
			 		csv << keyword.settingsRow
			 	end
			end

			# # Output All Sitelinks Settings Rows
			# @sitelinks.each do |sitelink|
			# 	csv << sitelink.outputSitelink
			# end

		end
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
			when "Location"
				output_row << @location
			when "Campaign Status"
				output_row << @campaign_status
			else
				output_row << nil
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
	attr_accessor :keywords, :name, :ad_group_status

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

	# => createAds - creates ad objects for the campaign based on seed keywords
	def createKeyword(keywordString)
		# Create ad group object
		@keywords << Keyword.new( campaign: @campaign,
		 		 				  ad_group: self,
						 		  keyword: keywordString)
	end

	# => createAds - creates ad objects for the campaign based on seed keywords
	def createAds
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
				output_row << nil
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
				output_row << nil
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
	def initialize( opts={campaign: nil,
						  ad_group: nil,
						  headline: "",
						  desc_line_1: "",
						  desc_line_2: "",
						  display_url: "",
						  destination_url: "",
						  device_preference: "All"} )
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@headline = opts[:headline]
		@desc_line_1 = opts[:desc_line_1]
		@desc_line_2 = opts[:desc_line_2]
		@display_url = opts[:display_url]
		@destination_url = opts[:url]
		@device_preference = opts[:device_preference]
	end

	def settingsRow
	end
end

#Create Campaign Factory to help with campaign creation
campaignFactory = CampaignFactory.new()

#Set Niche Parameters
seed = "Human Resources Certification"
niche = "Human Resources"
landingPage = "human-resources0"
areaOfStudy = "6B5B6155"
concentration = "01855C0C"

#Create Mod Broad City-State Campaign using Niche Parameters
campaign = campaignFactory.createModifiedBroadCityStateCampaign(seed, niche, landingPage, areaOfStudy, concentration)

#Output the campaign as a CSV
output_filename = "campaign-for-import.csv"
campaign.outputCampaign(output_filename)

puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"