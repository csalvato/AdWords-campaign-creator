require './BingCampaignFactory.rb'

# Create Bing campaign for Exact Match Keywords
# Class representing a "Campaign Factory" that can make City Campaigns
class LocalExactBingCampaignFactory < BingCampaignFactory
	def initialize(opts={})	
		opts = {location_code: "US"}.merge(opts) # Two Letter Location Code (i.e. "US" or "NY")
		@location_data = BingCampaign::location_data(opts[:location_code]) # Gives :name (New York), :id (28119) and :code (NY)
	end

	def create(seed, short_seed, niche, landingPage, area_of_study, concentration)

		base_campaign_name = "IP=#{@location_data[:code]} [#{niche}] [[#{@location_data[:code]}]] {#{seed}} (search; exact)"

		current_campaign = BingCampaign.new( name: base_campaign_name,
																		 location: @location_data[:code],
																		 location_id: @location_data[:id] )

		# Huge random number to mitigate collisions (but not completely ensure there are none)
		current_campaign.id_for_sitelinks = Random.new.rand(1..9999999999999999999999)

		createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration, current_campaign.id_for_sitelinks)

		page_headline = "Looking for " + seed + " in " + @location_data[:code] + "?"		
		ad_group_name = seed + " in " + @location_data[:name]
		adgroup = current_campaign.createAdGroup(ad_group_name)

		keywordString = "[#{seed}]"
		adgroup.createKeyword(keywordString)

		utm_campaign = "_src*BingAds_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
		destination_url = "http://koodlu.com/#{landingPage}/" +
						  "?area_of_study=#{area_of_study}" +
						  "&concentration=#{concentration}" + 
						  "&seed=#{seed.gsub(" ", "%20")}" + 
						  "&location=#{@location_data[:name].gsub(" ","%20")}" +
						  "&headline=#{page_headline.gsub(" ","%20")}" + 
						  "&utm_campaign=#{utm_campaign}" + 
						  "&utm_source=Google" + 
						  "&utm_medium=cpc"
		headline_options = createHeadlineOptions( niche, seed, short_seed )
		text_options = createTextOptions( niche, seed, short_seed )
		display_url_options = createDisplayURLOptions( niche, seed, short_seed )
		device_preference = "All"
		createAd(adgroup, headline_options, text_options, display_url_options, destination_url, device_preference)

		return current_campaign
	end

	def createHeadlineOptions( niche, seed, short_seed )
		[seed + " " + @location_data[:name],
		seed + " " + @location_data[:code],
		seed,
		short_seed + " " + @location_data[:name],
		short_seed + " " + @location_data[:code],
		short_seed]
	end

	def createTextOptions( niche, seed, short_seed )
		desc_line_1 = [@location_data[:name] + " " + seed + "?",
		@location_data[:code] + " " + seed + "?",
		@location_data[:name] + " " + short_seed + "?",
		@location_data[:code] + " " + short_seed + "?",
		seed + "?",
		short_seed + "?",
		seed,
		short_seed]

		desc_line_2 = ["Find " + @location_data[:name] + " " + seed,
		"Find " + @location_data[:code] + " " + seed,
		"Find " + seed,
		seed,
		"Find " + @location_data[:name] + " " + short_seed,
		"Find " + @location_data[:code] + " " + short_seed,
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

	def createDisplayURLOptions( niche, seed, short_seed )
		[ seed.gsub(" ","-") + ".koodlu.com/" + @location_data[:name].gsub(" ", "-"),
		seed.gsub(" ","-") + ".koodlu.com/" + @location_data[:code].gsub(" ", "-"),
		seed.gsub(" ","-") + ".koodlu.com",
		short_seed.gsub(" ","-") + ".koodlu.com/" + @location_data[:name].gsub(" ", "-"),
		short_seed.gsub(" ","-") + ".koodlu.com/" + @location_data[:code].gsub(" ", "-"),
		short_seed.gsub(" ","-") + ".koodlu.com"]
	end
end