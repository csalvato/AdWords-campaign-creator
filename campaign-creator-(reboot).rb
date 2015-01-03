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
	attr_accessor :campaign_name, :daily_budget, :languages, :location, :networks, :status, :sitelinks
	
	def initialize(opts={ campaign_name: "Default Name", 
						  daily_budget: 10.00, 
						  languages: "en", 
						  location: "United States",
						  networks: "Google Search;Search Partners", 
						  status: "Paused", 
						  seeds: []})
		@campaign_name = opts[:campaign_name]
		@daily_budget = opts[:daily_budget]
		@languages = opts[:languages]
		@location = opts[:location]
		@networks = opts[:networks]
		@status = opts[:status]
		@seeds = opts[:seeds]
		@ad_groups = Array[]
		@sitelinks = Array[]
		@output_row_headers = ["Campaign",
							  "Campaign Daily Budget",
							  "Languages",
							  "Networks",
							  "Location",
							  "Ad Group",
							  "Max CPC",
							  "Keyword", 
							  "Type",
							  "Headline",
							  "Description Line 1",
							  "Description Line 2",
							  "Display URL",
							  "Destination URL",
							  "Device Preference",
							  "Ad Group Status",
							  "Status"
							]
	end

	def createAdGroup(name, keywords, ads, ad_group_status)
		# Create ad group object
		@ad_groups << AdGroup.new( name: name,
								   campaign: self, 
								   keywords: Array[], 
								   ads: Array[], 
								   ad_group_status: "Enabled")
	end

	def createModifiedBroadAdGroups
		# For each keyword in the long tail keywords list, 
		# create an AdGroup that has 1 ad and 1 keyword
		keywords = createModifiedBroadLongTailKeywords
		keywords.each do |keyword|
			# Put a + before each word to create keyword
			adgroup_keywords = Array["+cna +classes +online"]
			# Somehow create ads for the createAdGroup call...
			createAdGroup(keyword, adgroup_keywords, )
		end
	end

	# Turns this campaign into an object represnting a Modified Broad Campaign
	# similar to the one Andy and I created to start CNA.
	def createModifiedBroadCampaign
		createModifiedBroadLongTailKeywords
		createModifiedBroadAdGroups
	end

	def outputCampaign

		CSV.open("campaign_for_import.csv", "wb") do |csv|
			# Create Headers
			csv << @output_row_headers
			# Output Campaign Settings Row
			csv << outputSettingsRow

			# Output All AdGroups Settings Rows
			@adgroups.each do |adgroup|
				csv << adgroup.outputAdGroup
			end

			# Output All Sitelinks Settings Rows
			@sitelinks.each do |sitelink|
				csv << sitelink.outputSitelink
			end

		end
	end

	# Outputs the settings row as an array
	def outputSettingsRow
		output_row = []
		
		@output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign_name
			when "Campaign Daily Budget"
				output_row << @daily_budget
			when "Languages"
				output_row << @languages
			when "Networks"
				output_row << @networks 
			when "Status"
				output_row << @status
			else
				output_row << ""
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
	attr_accessor :createAds, :createKeywords

	def initialize( opts={ name: "Default AdGroup Name", campaign: nil, keywords: Array[], ads: Array[], ad_group_status: "Enabled"} )
		@name = opts[:name]
		@campaign = opts[:campaign]
		@keywords = opts[:keywords]
		@ads = opts[:ads]
		@ad_group_status = opts[:ad_group_status]
		
		createAds
		createKeywords
	end

	# => createAds - creates ad objects for the campaign based on seed keywords
	def createAds
	end

	# => createKeywords - creates keyword objects for the campaign based on seed keywords
	def createKeywords
	end

	def outputSettingsRow
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
	def initialize( opts={campaign: nil,
		 				  ad_group: nil,
		 				  max_cpc: 0.50,
		 				  keyword: "",
		 				  type: "Broad",
		 				  device: "All"} )
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@max_cpc = opts[:max_cpc]
		@keyword = opts[:keyword]
		@type = opts[:type]
		@device = opts[:device]
	end

	def outputSettingsRow
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

	def outputSettingsRow
	end
end

campaign = Campaign.new()
campaign.outputCompleteCampaignFromSeeds

puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"