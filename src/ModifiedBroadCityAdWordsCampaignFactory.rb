require './AdWordsCampaignFactory.rb'

# Class representing a "Campaign Factory" that can make City Campaigns
class ModifiedBroadCityAdWordsCampaignFactory < AdWordsCampaignFactory
	def initialize(opts={})	
		opts = {location_file_path: "location-data.csv"}.merge(opts)
		# Read all locations from file and store as array of arrays
		@locations = CSV.read(opts[:location_file_path], :headers => true, :encoding => 'windows-1251:utf-8')
	end

	def create(seed, short_seed, niche, landingPage, area_of_study, concentration)

		base_campaign_name = "IP=US [#{niche}] [[VA]] {#{seed} +SUBLOCATION} (search; modbroad)"

		campaigns = Array[]
		new_campaign = Campaign.new( name: base_campaign_name)
		campaign_counter = 1
		if @locations.length > Campaign::MAX_ADGROUPS_PER_CAMPAIGN
			new_campaign.name =  base_campaign_name + " Group " + campaign_counter.to_s
		end

		campaigns << new_campaign 

		current_campaign = campaigns.last
		createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration)


		@locations.each_with_index do |row, index|
			# Set some initial variables
			city = row["City"]

			sublocation = city

			page_headline = "Looking for " + seed + " in " + city + "?"

			ad_group_name = seed + " in " + city
			adgroup = current_campaign.createAdGroup(ad_group_name)

			keywordString = "+" + (seed + " " + city).gsub(" ", " +")
			adgroup.createKeyword(keywordString)


			utm_campaign = "_src*adwords_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
			destination_url = "http://koodlu.com/#{landingPage}/" +
							  "?area_of_study=#{area_of_study}" +
							  "&concentration=#{concentration}" + 
							  "&seed=#{seed.gsub(" ", "%20")}" + 
							  "&location=#{sublocation.gsub(" ","%20")}" +
							  "&headline=#{page_headline.gsub(" ","%20")}" + 
							  "&utm_campaign=#{utm_campaign}" + 
							  "&utm_source=Google" + 
							  "&utm_medium=cpc"
			headline_options = createHeadlineOptions( niche, seed, short_seed, city )
			desc_line_1_options = createDescLine1Options( niche, seed, short_seed, city )
			desc_line_2_options = createDescLine2Options( niche, seed, short_seed, city )
			display_url_options = createDisplayURLOptions( niche, seed, short_seed, city )
			device_preference = "All"
			createAd(adgroup, headline_options, desc_line_1_options, desc_line_2_options, display_url_options, destination_url, device_preference)

			ad_group_count = index + 1
			if ad_group_count % Campaign::MAX_ADGROUPS_PER_CAMPAIGN == 0
				campaign_counter += 1
				campaigns << Campaign.new( name: base_campaign_name + " Group " + campaign_counter.to_s )
				current_campaign = campaigns.last
				createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration)
			end
		end
		return campaigns
	end

	def createHeadlineOptions( niche, seed, short_seed, city )
		[seed + " " + city,
		seed,
		short_seed + " " + city,
		short_seed,
		niche + " Classes " + city,
		niche + " " + city]
	end

	def createDescLine1Options( niche, seed, short_seed, city )
		[city + " " + seed + "?",
		city + " " + short_seed + "?",
		seed + "?",
		niche + " Classes?",
		short_seed + "?",
		seed,
		short_seed]
	end

	def createDescLine2Options( niche, seed, short_seed, city )
		["Find " + city + " " + seed,
		"Find " + seed,
		seed,
		"Find " + city + " " + short_seed,
		"Find " + short_seed,
		short_seed]
	end

	def createDisplayURLOptions( niche, seed, short_seed, city )
		[ seed.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		seed.gsub(" ","-") + ".koodlu.com",
		niche.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		niche.gsub(" ","-") + ".koodlu.com",
		short_seed.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		short_seed.gsub(" ","-") + ".koodlu.com"]
	end
end