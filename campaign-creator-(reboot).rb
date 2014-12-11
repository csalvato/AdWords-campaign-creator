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
		# => outputCompleteCampaignFromSeeds (outputs a CSV file of the complete campaign data ready for importing)
		# => outputSettingsRow (outputs the settings row for the campaign as ready for campaign import CSV)
		# => createAdGroups - creates ad group objects for the campaign based on seed keywords
class Campaign
	attr_accessor :campaign_name, :daily_budget, :languages, :networks, :status
	
	def initialize(opts={ campaign_name: "Default Name", 
						  daily_budget: 10.00, 
						  languages: "en", 
						  networks: "Google Search", 
						  status: "Paused", 
						  seeds: []})
		@campaign_name = opts[:campaign_name]
		@daily_budget = opts[:daily_budget]
		@languages = opts[:languages]
		@networks = opts[:networks]
		@status = opts[:status]
		@seeds = opts[:seeds]
		
		createAdGroups
	end

	def createAdGroups
	end

	def outputSettingsRow
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

	def initialize( opts={ campaign: nil, keywords: Array[], ads: Array[], ad_group_status: "Enabled"} )
		campaign = opts[:campaign]
		keywords = opts[:keywords]
		ads = opts[:ads]
		ad_group_status = opts[:ad_group_status]
		
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
		campaign = opts[:campaign]
		ad_group = opts[:ad_group]
		max_cpc = opts[:max_cpc]
		keyword = opts[:keyword]
		type = opts[:type]
		device = opts[:device]
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
		campaign = opts[:campaign]
		ad_group = opts[:ad_group]
		headline = opts[:headline]
		desc_line_1 = opts[:desc_line_1]
		desc_line_2 = opts[:desc_line_2]
		display_url = opts[:display_url]
		destination_url = opts[:url]
		device_preference = opts[:device_preference]
	end

	def outputSettingsRow
	end
end

campaign = Campaign.new()

puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"