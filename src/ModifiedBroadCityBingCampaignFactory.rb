require './BingCampaignFactory.rb'

class ModifiedBroadCityBingCampaignFactory < BingCampaignFactory
	def initialize(opts={})	
		opts = {location_file_path: "location-data.csv"}.merge(opts)
		# Read all locations from file and store as array of arrays
		@locations = CSV.read(opts[:location_file_path], :headers => true, :encoding => 'windows-1251:utf-8')
	end

	def create(seed, short_seed, niche, landingPage, area_of_study, concentration)

		base_campaign_name = "IP=US [#{niche}] [[VA]] {#{seed} +SUBLOCATION} (search; modbroad)"

		campaigns = Array[]
		new_campaign = BingCampaign.new( name: base_campaign_name)
		new_campaign.mobile_bid_adjustment = -100
		new_campaign.tablet_bid_adjustment = -100

		campaign_counter = 1
		if @locations.length > BingCampaign::MAX_ADGROUPS_PER_CAMPAIGN
			new_campaign.name =  base_campaign_name + " Group " + campaign_counter.to_s
			@total_created_seeds += 1
			new_campaign.id_for_sitelinks = @total_created_seeds + 100000000 # Offset the id_for_sitelinks by 100000000 for City Campaigns
		end

		campaigns << new_campaign 

		current_campaign = campaigns.last
		createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration, current_campaign.id_for_sitelinks)


		@locations.each_with_index do |row, index|
			# Set some initial variables
			city = row["City"]

			sublocation = city

			page_headline = "Looking for " + seed + " in " + city + "?"

			ad_group_name = seed + " in " + city
			adgroup = current_campaign.createAdGroup(ad_group_name)

			keywordString = "+" + (seed + " " + city).gsub(" ", " +")
			adgroup.createKeyword(keywordString)


			utm_campaign = "_src*BingAds_d*dt_d2*{IfMobile:mb}{IfNotMobile:dt}_k*{QueryString}_m*{MatchType}_c*{AdId}_p*{adposition}_n*{IfSearch:b}{IfContent:d}"
			destination_url = "http://koodlu.com/#{landingPage}/" +
							  "?area_of_study=#{area_of_study}" +
							  "&concentration=#{concentration}" + 
							  "&seed=#{seed.gsub(" ", "%20")}" + 
							  "&location=#{sublocation.gsub(" ","%20")}" +
							  "&headline=#{page_headline.gsub(" ","%20")}" + 
							  "&utm_campaign=#{utm_campaign}" + 
							  "&utm_source=Bing" + 
							  "&utm_medium=cpc"
			title_options = createHeadlineOptions( niche, seed, short_seed, city )
			text_options = createTextOptions( niche, seed, short_seed, city )
			display_url_options = createDisplayURLOptions( niche, seed, short_seed, city )
			device_preference = "All"
			createAd(adgroup, title_options, text_options, display_url_options, destination_url, device_preference)

			ad_group_count = index + 1
			if ad_group_count % BingCampaign::MAX_ADGROUPS_PER_CAMPAIGN == 0
				campaign_counter += 1
				new_campaign = BingCampaign.new( name: base_campaign_name + " Group " + campaign_counter.to_s )
				new_campaign.mobile_bid_adjustment = -100
				new_campaign.tablet_bid_adjustment = -100
				
				new_campaign.id_for_sitelinks = @total_created_seeds + 100000000 # Offset the id_for_sitelinks by 100000000 for City Campaigns 
				campaigns << new_campaign
				current_campaign = campaigns.last
				createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration, current_campaign.id_for_sitelinks)
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

	def createTextOptions( niche, seed, short_seed, city )
		desc_line_1 = [city + " " + seed + "?",
		city + " " + short_seed + "?",
		seed + "?",
		niche + " Classes?",
		short_seed + "?",
		seed,
		short_seed]

		desc_line_2 = ["Find " + city + " " + seed,
		"Find " + seed,
		seed,
		"Find " + city + " " + short_seed,
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

	def createDisplayURLOptions( niche, seed, short_seed, city )
		[ seed.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		seed.gsub(" ","-") + ".koodlu.com",
		niche.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		niche.gsub(" ","-") + ".koodlu.com",
		short_seed.gsub(" ","-") + ".koodlu.com/" + city.gsub(" ", "-"),
		short_seed.gsub(" ","-") + ".koodlu.com"]
	end
end