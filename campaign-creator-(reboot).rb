# Create campaign CSV files
start_time = Time.now
puts "Starting Script..."

# Class representing a campaign
	# Properties:
		# => campaign_name (string - "IP={US}Modbroad, blah blah")
		# => daily_budget (float - 10.00)
		# => languages (string - "en")
		# => networks (string - "Google Search" [does this specify partners, too?])
		# => Status (string - "enabled")
	# Methods:
		# => outputCompleteCampaign (outputs a CSV file of the complete campaign data ready for importing)
		# => outputSettingsRow (outputs the settings row for the campaign as ready for campaign import CSV)
class Campaign
end

# Class representing an Ad Group (a group of keywords)
	# Properties:
		# => Campaign (Campaign object this ad group belongs to)
		# => Keywords (Array of objects of Keyword Class)
		# => Ads (Arry of objects of Ad class
		# => Ad Group Status (string - "Enabled")
	# Methods:
		# => outputSettingsRow (outputs the settings row for the Ad Group as ready for campaign import CSV)

class AdGroup
end

# Class representing a Keyword	
	# Properties:
		# => Campaign (Campaign object this keyword belongs to)
		# => Ad Group (Ad Group object this belongs to)
		# => Max CPC (float - 10.00)
		# => Keyword (string - "[CNA Classes Online]")
		# => Type - (string - "Broad")
		# => Device Preference (string - "All")
	# Methods:
		# => outputSettingsRow (outputs the settings row for the Ad Group as ready for campaign import CSV)
class Keyword
end

# Class representing an Ad
	# Properties:
		# => Campaign (Campaign object this ad belongs to)
		# => Ad Group (Ad Group object this belongs to)
		# => Description Line 1 (string - max length 25)
		# => Description Line 2 (string - max length 25)
		# => Display URL (string - max length 35)
		# => Destination URL
		# => Device Preference (string - "All")
	# Methods:
		# => outputSettingsRow (outputs the settings row for the Ad Group as ready for campaign import CSV)
class Ad
end

puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"