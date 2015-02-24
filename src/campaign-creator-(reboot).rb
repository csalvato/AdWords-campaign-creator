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
require './ModifiedBroadCityStateAdWordsCampaignFactory.rb'
require './ModifiedBroadCityAdWordsCampaignFactory.rb'
require './ModifiedBroadCityStateBingCampaignFactory.rb'
require './ModifiedBroadCityBingCampaignFactory.rb'

# Create array to hold all the campaigns once generation is completed
adwordsCampaigns = Array[]
bingCampaigns = []

#Set Niche Parameters
seeds_file_path = "../seeds-for-next-import.csv"
seeds = CSV.read(seeds_file_path, :headers => true, :encoding => 'windows-1251:utf-8')

seeds.each_with_index do |seed_data, index|
	seed = seed_data["Seed"]
	short_seed = seed_data["Short Seed"]
	niche = seed_data["Niche"]
	landingPage = seed_data["Landing Page"]
	areaOfStudy = seed_data["Area of Study"]
	concentration = seed_data["Concentration"]
	
	if seed_data["Create AdWords City State?"].to_s.strip.length == 0 #Checks if nil, empty, or whitespace
		createCityState = false
	else
		createCityState = true
	end
	
	if seed_data["Create AdWords City?"].to_s.strip.length == 0 #Checks if nil, empty, or whitespace
		createCity = false
	else
		createCity = true
	end

	if seed_data["Create Bing City State?"].to_s.strip.length == 0 #Checks if nil, empty, or whitespace
		createBingCityState = false
	else
		createBingCityState = true
	end
	
	if seed_data["Create Bing City?"].to_s.strip.length == 0 #Checks if nil, empty, or whitespace
		createBingCity = false
	else
		createBingCity = true
	end

	# Create Campaign Factory to help with campaign creation
	if createCityState
		cityStateCampaignFactory = ModifiedBroadCityStateAdWordsCampaignFactory.new(location_file_path: "../city-state-location-data.csv")
		adwordsCampaigns.concat( cityStateCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Adwords City/State Campaign Created"
	end

	if createCity
		cityCampaignFactory = ModifiedBroadCityAdWordsCampaignFactory.new(location_file_path: "../city-location-data.csv")
		adwordsCampaigns.concat( cityCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Adwords City Campaign Created"
	end

	# Create Campaign Factory to help with campaign creation
	if createBingCityState
		cityBingStateCampaignFactory = ModifiedBroadCityStateBingCampaignFactory.new(location_file_path: "../city-state-location-data.csv")
		bingCampaigns.concat( cityBingStateCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Bing City/State Campaign Created"
	end

	if createBingCity
		cityBingCampaignFactory = ModifiedBroadCityBingCampaignFactory.new(location_file_path: "../city-location-data.csv")
		bingCampaigns.concat( cityBingCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Bing City Campaign Created"
	end
end

#Output the campaigns as a CSV
output_filename = "../adwords-campaigns-for-import.csv"
first = true
adwordsCampaigns.each_with_index do |campaign, index|
	first = false if index > 0
	campaign.outputCampaign(output_filename, first)
	puts "Finished writing CSV for " + campaign.name
end

output_filename = "../bing-campaigns-for-import.csv"
first = true
bingCampaigns.each_with_index do |campaign, index|
	first = false if index > 0
	campaign.outputCampaign(output_filename, first)
	puts "Finished writing CSV for " + campaign.name
end

say_string = "All Done!"
`say "#{say_string}"`
puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"