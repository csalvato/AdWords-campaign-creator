require './AdWordsCampaignFactory.rb'

# Class representing a "Campaign Factory" that can make City/State Campaigns
class ModifiedBroadCityStateAdWordsCampaignFactory < AdWordsCampaignFactory
	def initialize(opts={})	
		opts = {location_file_path: "location-data.csv"}.merge(opts)
		# Read all locations from file and store as array of arrays
		@locations = CSV.read(opts[:location_file_path], :headers => true, :encoding => 'windows-1251:utf-8')
	end

	def create(seed, short_seed, niche, landingPage, area_of_study, concentration)

		base_campaign_name = "IP=US [#{niche}] {#{seed} +SUBLOCATION +LOCATIONCODE} (search; modbroad)"

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
			state_name = row["State Name"]
			state_code = row["State Code"]

			location = state_name
			sublocation = city
			locationcode = state_code

			page_headline = "Looking for " + seed + " in " + city + ", " + state_code + "?"

			ad_group_name = seed + " in " + city + " " + state_code
			adgroup = current_campaign.createAdGroup(ad_group_name)

			keywordString = "+" + (seed + " " + city + " " + state_code).gsub(" ", " +")
			adgroup.createKeyword(keywordString)


			utm_campaign = "_src*adwords_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
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
			headline_options = createHeadlineOptions( niche, seed, short_seed, city, state_code, state_name )
			desc_line_1_options = createDescLine1Options( niche, seed, short_seed, city, state_code, state_name )
			desc_line_2_options = createDescLine2Options( niche, seed, short_seed, city, state_code, state_name )
			display_url_options = createDisplayURLOptions( niche, seed, short_seed, city, state_code, state_name )
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

	def createHeadlineOptions( niche, seed, short_seed, city, state_code, state_name )
		[seed + " " + city + " " + state_code,
		seed + " " + city,
		seed + " " + state_name,
		seed + " " + state_code,
		seed,
		short_seed + " " + city + " " + state_code,
		short_seed + " " + city,
		short_seed + " " + state_name,
		short_seed + " " + state_code,
		short_seed]
	end

	def createDescLine1Options( niche, seed, short_seed, city, state_code, state_name )
		[city + " " + seed + " " + state_name + "?",
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
	end

	def createDescLine2Options( niche, seed, short_seed, city, state_code, state_name )
		["Find " + city + " " + seed,
		"Find " + state_name + " " + seed,
	    "Find " + state_code + " " + seed,
		"Find " + seed,
		seed,
		"Find " + city + " " + short_seed,
		"Find " + state_name + " " + short_seed,
	    "Find " + state_code + " " + short_seed,
		"Find " + short_seed,
		short_seed]
	end

	def createDisplayURLOptions( niche, seed, short_seed, city, state_code, state_name )
		[ seed.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		seed.gsub(" ","-") + ".koodlu.com/" + state_name.gsub(" ", "-"),
		seed.gsub(" ","-") + ".koodlu.com/" + state_code,
		seed.gsub(" ","-") + ".koodlu.com",
		niche.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		niche.gsub(" ","-") + ".koodlu.com/" + state_name.gsub(" ", "-"),
		niche.gsub(" ","-") + ".koodlu.com/" + state_code,
		niche.gsub(" ","-") + ".koodlu.com",
		short_seed.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		short_seed.gsub(" ","-") + ".koodlu.com/" + state_name.gsub(" ", "-"),
		short_seed.gsub(" ","-") + ".koodlu.com/" + state_code,
		short_seed.gsub(" ","-") + ".koodlu.com"]
	end
end