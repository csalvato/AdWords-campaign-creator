require 'csv'
require './LocalExactAdWordsCampaignFactory.rb'
require './LocalExactBingCampaignFactory.rb'


seeds_file_path = "../seeds-for-next-import.csv"

seeds = CSV.read(seeds_file_path, :headers => true, :encoding => 'windows-1251:utf-8')

adwordsCampaigns = []
bingCampaigns =[]

seeds.each_with_index do |seed_data, index|
	seed = seed_data["Seed"]
	short_seed = seed_data["Short Seed"]
	niche = seed_data["Niche"]
	landingPage = seed_data["Landing Page"]
	areaOfStudy = seed_data["Area of Study"]
	concentration = seed_data["Concentration"]

	exactCampaignFactory = LocalExactAdWordsCampaignFactory.new(location_code: "VA")
	adwordsCampaigns << exactCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration)
	puts seed + " Adwords Exact Match VA Campaign Created"

	exactBingCampaignFactory = LocalExactBingCampaignFactory.new(location_code: "VA")
	bingCampaigns << exactBingCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration)
	puts seed + " Bing Exact Match VA Campaign Created"

	#Output the campaigns as a CSV
	output_filename = "../adwords-campaigns-for-import.csv"
	first = true
	adwordsCampaigns.each_with_index do |campaign, index|
		first = false if index > 0
		campaign.outputCampaign(output_filename, first)
		puts "Finished writing CSV for " + campaign.name
	end

	#Output the campaigns as a CSV
	output_filename = "../bing-campaigns-for-import.csv"
	first = true
	bingCampaigns.each_with_index do |campaign, index|
		first = false if index > 0
		campaign.outputCampaign(output_filename, first)
		puts "Finished writing CSV for " + campaign.name
	end
end