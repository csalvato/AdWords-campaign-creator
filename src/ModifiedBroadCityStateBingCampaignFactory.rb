require './BingCampaignFactory.rb'

class ModifiedBroadCityStateBingCampaignFactory < BingCampaignFactory
	def create(seed, short_seed, niche, landingPage, area_of_study, concentration)

		base_campaign_name = "IP=US [#{niche}] {#{seed} +SUBLOCATION +LOCATIONCODE} (search; modbroad)"

		campaigns = Array[]
		new_campaign = BingCampaign.new( name: base_campaign_name )
		new_campaign.mobile_bid_adjustment = -100
		new_campaign.tablet_bid_adjustment = -100

		campaign_counter = 1
		if @locations.length > BingCampaign::MAX_ADGROUPS_PER_CAMPAIGN
			new_campaign.name =  base_campaign_name + " Group " + campaign_counter.to_s
			@total_created_seeds += 1
			new_campaign.id_for_sitelinks = @total_created_seeds
		end

		campaigns << new_campaign 

		current_campaign = campaigns.last
		createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration, current_campaign.id_for_sitelinks)


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

			utm_campaign = "_src*BingAds_d*dt_d2*{IfMobile:mb}{IfNotMobile:dt}_k*{QueryString}_m*{MatchType}_c*{AdId}_p*{adposition}_n*{IfSearch:b}{IfContent:d}"
			destination_url = "http://koodlu.com/#{landingPage}/" +
							  "?area_of_study=#{area_of_study}" +
							  "&concentration=#{concentration}" + 
							  "&seed=#{seed.gsub(" ", "%20")}" + 
							  "&location=#{location}" +
							  "&sublocation=#{sublocation.gsub(" ","%20")}" + 
							  "&locationcode=#{locationcode}" + 
							  "&headline=#{page_headline.gsub(" ","%20")}" + 
							  "&utm_campaign=#{utm_campaign}" + 
							  "&utm_source=Bing" + 
							  "&utm_medium=cpc"
			title_options = createHeadlineOptions( niche, seed, short_seed, city, state_code, state_name )
			text_options = createTextOptions( niche, seed, short_seed, city, state_code, state_name )
			display_url_options = createDisplayURLOptions( niche, seed, short_seed, city, state_code, state_name )
			device_preference = "All"
			createAd(adgroup, title_options, text_options, display_url_options, destination_url, device_preference)

			ad_group_count = index + 1
			if ad_group_count % BingCampaign::MAX_ADGROUPS_PER_CAMPAIGN == 0
				campaign_counter += 1
				new_campaign = BingCampaign.new( name: base_campaign_name + " Group " + campaign_counter.to_s )
				new_campaign.mobile_bid_adjustment = -100
				new_campaign.tablet_bid_adjustment = -100
				new_campaign.id_for_sitelinks = @total_created_seeds
				
				campaigns << new_campaign
				current_campaign = campaigns.last
				createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration, current_campaign.id_for_sitelinks)
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

	def createTextOptions( niche, seed, short_seed, city, state_code, state_name )
		desc_line_1 = [city + " " + seed + " " + state_name + "?",
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

		desc_line_2 = ["Find " + city + " " + seed,
		"Find " + state_name + " " + seed,
	    "Find " + state_code + " " + seed,
		"Find " + seed,
		seed,
		"Find " + city + " " + short_seed,
		"Find " + state_name + " " + short_seed,
	    "Find " + state_code + " " + short_seed,
		"Find " + short_seed,
		short_seed]

		options = []
		desc_line_1.each do |line_1|
			desc_line_2.each do |line_2|
				options << line_1 + " " + line_2
			end
		end

		options
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