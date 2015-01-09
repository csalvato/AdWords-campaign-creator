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

class CampaignFactory
	def initialize(opts={})	
	end

	def selectOptionOfLength (options_array, max_length)
		options_array.each do |option|
			if option.length <= max_length
				return option
			end 
		end

		error_message = "ERROR: None Under " + max_length.to_s + " Characters!"
		puts error_message
		return error_message
	end
end

class AdWordsCampaignFactory < CampaignFactory

	def createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration)
		sitelink_page_headline = "Looking for " + seed + "?"
		sitelink_utm_campaign = "_src*adwords_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
		sitelink_destination_url = "http://koodlu.com/#{landingPage}/" +
									"?area_of_study=#{area_of_study}" + 
									"&concentration=#{concentration}" +
									"&seed=#{seed.gsub(" ", "%20")}" +
									"&headline=#{sitelink_page_headline.gsub(" ","%20").gsub("?","%3f")}" +
									"&utm_campaign=#{sitelink_utm_campaign}" +
									"&utm_source=Google" +
									"&utm_medium=cpc"

		createSitelink1(current_campaign, niche, seed, short_seed, sitelink_destination_url)
		createSitelink2(current_campaign, niche, seed, short_seed, sitelink_destination_url)
		createSitelink3(current_campaign, niche, seed, short_seed, sitelink_destination_url)
		createSitelink4(current_campaign, niche, seed, short_seed, sitelink_destination_url)
	end

	def createSitelink1(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Find " + seed + " Near You",
							  		  seed + " Near You",
							          "Find " + seed,
							      	  seed,
							      	  "Find " + short_seed + " Near You",
							  		  short_seed + " Near You",
							          "Find " + short_seed,
							      	  short_seed,
							      	  "Find " + niche + " Training",
							      	  niche + " Training"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, Sitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Looking for " + seed + "?",
										"Need " + seed + "?",
										seed + "?",
										"Looking for " + short_seed + "?",
										"Need " + short_seed + "?",
										short_seed + "?",
										"Looking for " + niche + "Classes?",
										"Need " + niche + "?",
										niche + " Classes?"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["Find " + seed + " Now",
										"Find " + short_seed + " Now",
										seed + " Now",
										short_seed + " Now",
										niche + " Training Now",
										"Quick Training Finder"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end

	def createSitelink2(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Quick " + seed + " Finder",
							  		  seed + " Finder",
							  		  "Quick" + short_seed + " Finder",
							          niche + " Classes Finder",
							      	  seed,
							      	  short_seed + " Finder"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, Sitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Use our " + seed + " Finder",
										"Use " + seed + " Finder",
										"Use our " + short_seed + " Finder",
										"Use " + short_seed + " Finder",
										"Use " + niche + " Classes Finder",
										"Use Our Classes Finder"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["To Find " + seed + " Now",
										"To Find " + seed,
										"To Find " + short_seed + " Now",
										"To Find " + seed,
										"To Find " + niche + " Classes Now",
										"To Find " + niche + " Classes",
										"To Find Classes Now"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end

	def createSitelink3(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Submit Your Info Online"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, Sitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Take 60 Seconds To Submit Your Info"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["To Find " + seed + " Now",
										"To Find " + seed,
										"To Find " + short_seed + " Now",
										"To Find " + seed,
										"To Find " + niche + " Classes Now",
										"To Find " + niche + " Classes",
										"To Find Classes Now"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end

	def createSitelink4(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Takes Less Than 1 Min"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, Sitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Find " + seed + " Fast",
										"Find " + seed,
										"Find " + short_seed + " Fast",
										"Find " + short_seed,
										"Find Classes Fast"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["Using Our " + seed + " Search",
										"Using " + seed + " Search",
										seed + " Search",
										"Using Our " + short_seed + " Search",
										"Using " + short_seed + " Search",
										short_seed + " Search",
										"Using Our " + niche + " Classes Search",
										"Using " + niche + " Classes Search",
										niche + " Classes Search"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, Sitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url)
	end

	def createAd(adgroup, headline_options, desc_line_1_options, desc_line_2_options, display_url_options, destination_url, device_preference)
		headline = selectOptionOfLength( headline_options, Ad::MAX_AD_HEADLINE_LENGTH )
		desc_line_1 = selectOptionOfLength( desc_line_1_options, Ad::MAX_AD_DESCRIPTION_LENGTH )
		desc_line_2 = selectOptionOfLength( desc_line_2_options, Ad::MAX_AD_DESCRIPTION_LENGTH )
		display_url = selectOptionOfLength( display_url_options, Ad::MAX_AD_DISPLAY_URL_LENGTH)
		
		adgroup.createAd(headline, desc_line_1, desc_line_2, display_url, destination_url, device_preference)
	end

end

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

# Class representing a "Campaign Factory" that can make City Campaigns
class ModifiedBroadCityAdWordsCampaignFactory < AdWordsCampaignFactory
	def initialize(opts={})	
		opts = {location_file_path: "location-data.csv"}.merge(opts)
		# Read all locations from file and store as array of arrays
		@locations = CSV.read(opts[:location_file_path], :headers => true, :encoding => 'windows-1251:utf-8')
	end

	def create(seed, short_seed, niche, landingPage, area_of_study, concentration)

		base_campaign_name = "IP=US [#{niche}] {#{seed} +SUBLOCATION} (search; modbroad)"

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

class BingCampaignFactory < CampaignFactory
	def createCampaignSitelinks(campaign, niche, seed, short_seed, landingPage, area_of_study, concentration)
		sitelink_page_headline = "Looking for " + seed + "?"
		sitelink_utm_campaign = "_src*BingAds_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
		sitelink_destination_url = "http://koodlu.com/#{landingPage}/" +
									"?area_of_study=#{area_of_study}" + 
									"&concentration=#{concentration}" +
									"&seed=#{seed.gsub(" ", "%20")}" +
									"&headline=#{sitelink_page_headline.gsub(" ","%20").gsub("?","%3f")}" +
									"&utm_campaign=#{sitelink_utm_campaign}" +
									"&utm_source=Google" +
									"&utm_medium=cpc"

		createSitelink1(campaign, niche, seed, short_seed, sitelink_destination_url)
		createSitelink2(campaign, niche, seed, short_seed, sitelink_destination_url)
		createSitelink3(campaign, niche, seed, short_seed, sitelink_destination_url)
		createSitelink4(campaign, niche, seed, short_seed, sitelink_destination_url)
	end

	def createSitelink1(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Find " + seed + " Near You",
							  		  seed + " Near You",
							          "Find " + seed,
							      	  seed,
							      	  "Find " + short_seed + " Near You",
							  		  short_seed + " Near You",
							          "Find " + short_seed,
							      	  short_seed,
							      	  "Find " + niche + " Training",
							      	  niche + " Training"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, BingSitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Looking for " + seed + "?",
										"Need " + seed + "?",
										seed + "?",
										"Looking for " + short_seed + "?",
										"Need " + short_seed + "?",
										short_seed + "?",
										"Looking for " + niche + "Classes?",
										"Need " + niche + "?",
										niche + " Classes?"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["Find " + seed + " Now",
										"Find " + short_seed + " Now",
										seed + " Now",
										short_seed + " Now",
										niche + " Training Now",
										"Quick Training Finder"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createBingSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url, 1)
	end

	def createSitelink2(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Quick " + seed + " Finder",
							  		  seed + " Finder",
							  		  "Quick" + short_seed + " Finder",
							          niche + " Classes Finder",
							      	  seed,
							      	  short_seed + " Finder"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, BingSitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Use our " + seed + " Finder",
										"Use " + seed + " Finder",
										"Use our " + short_seed + " Finder",
										"Use " + short_seed + " Finder",
										"Use " + niche + " Classes Finder",
										"Use Our Classes Finder"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["To Find " + seed + " Now",
										"To Find " + seed,
										"To Find " + short_seed + " Now",
										"To Find " + seed,
										"To Find " + niche + " Classes Now",
										"To Find " + niche + " Classes",
										"To Find Classes Now"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url, 2)
	end

	def createSitelink3(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Submit Your Info Online"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, BingSitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Take 60 Seconds To Submit Your Info"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["To Find " + seed + " Now",
										"To Find " + seed,
										"To Find " + short_seed + " Now",
										"To Find " + seed,
										"To Find " + niche + " Classes Now",
										"To Find " + niche + " Classes",
										"To Find Classes Now"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url, 3)
	end

	def createSitelink4(campaign, niche, seed, short_seed, sitelink_destination_url)
		sitelink_link_text_options = ["Takes Less Than 1 Min"]
  	    sitelink_link_text = selectOptionOfLength( sitelink_link_text_options, BingSitelink::MAX_LINK_TEXT_LENGTH )
		
		sitelink_desc_line_1_options = ["Find " + seed + " Fast",
										"Find " + seed,
										"Find " + short_seed + " Fast",
										"Find " + short_seed,
										"Find Classes Fast"]
		sitelink_desc_line_1 = selectOptionOfLength( sitelink_desc_line_1_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		sitelink_desc_line_2_options = ["Using Our " + seed + " Search",
										"Using " + seed + " Search",
										seed + " Search",
										"Using Our " + short_seed + " Search",
										"Using " + short_seed + " Search",
										short_seed + " Search",
										"Using Our " + niche + " Classes Search",
										"Using " + niche + " Classes Search",
										niche + " Classes Search"]
		sitelink_desc_line_2 = selectOptionOfLength( sitelink_desc_line_2_options, BingSitelink::MAX_DESCRIPTION_LENGTH )

		url = sitelink_destination_url + "&sitelink-text=#{sitelink_link_text.gsub(" ","-")}"
		campaign.createSitelink(sitelink_link_text, sitelink_desc_line_1, sitelink_desc_line_2, url, 4)
	end

	def createAd(adgroup, title_options, text_options, display_url_options, destination_url, device_preference)

		headline = selectOptionOfLength( headline_options, BingAd::MAX_AD_TITLE_LENGTH )
		text = selectOptionOfLength( text_options, BingAd::MAX_AD_TEXT_LENGTH )
		display_url = selectOptionOfLength( display_url_options, BingAd::MAX_AD_DISPLAY_URL_LENGTH)
		
		adgroup.createAd(title, text, display_url, destination_url, device_preference)
	end
end

class ModifiedBroadCityStateBingCampaignFactory < BingCampaignFactory
end

class ModifiedBroadCityBingCampaignFactory < BingCampaignFactory
	def initialize(opts={})	
		opts = {location_file_path: "location-data.csv"}.merge(opts)
		# Read all locations from file and store as array of arrays
		@locations = CSV.read(opts[:location_file_path], :headers => true, :encoding => 'windows-1251:utf-8')
	end

	def create(seed, short_seed, niche, landingPage, area_of_study, concentration)

		base_campaign_name = "IP=US [#{niche}] {#{seed} +SUBLOCATION} (search; modbroad)"

		campaigns = Array[]
		new_campaign = BingCampaign.new( name: base_campaign_name)
		campaign_counter = 1
		if @locations.length > BingCampaign::MAX_ADGROUPS_PER_CAMPAIGN
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


			utm_campaign = "_src*BingAds_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
			destination_url = "http://koodlu.com/#{landingPage}/" +
							  "?area_of_study=#{area_of_study}" +
							  "&concentration=#{concentration}" + 
							  "&seed=#{seed.gsub(" ", "%20")}" + 
							  "&location=#{sublocation.gsub(" ","%20")}" +
							  "&headline=#{page_headline.gsub(" ","%20")}" + 
							  "&utm_campaign=#{utm_campaign}" + 
							  "&utm_source=Google" + 
							  "&utm_medium=cpc"
			title_options = createHeadlineOptions( niche, seed, short_seed, city )
			text_options = createTextOptions( niche, seed, short_seed, city )
			display_url_options = createDisplayURLOptions( niche, seed, short_seed, city )
			device_preference = "All"
			createAd(adgroup, title_options, text_options, display_url_options, destination_url, device_preference)

			ad_group_count = index + 1
			if ad_group_count % BingCampaign::MAX_ADGROUPS_PER_CAMPAIGN == 0
				campaign_counter += 1
				campaigns << BingCampaign.new( name: base_campaign_name + " Group " + campaign_counter.to_s )
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
	attr_accessor :output_row_headers, :status, :name
	MAX_ADGROUPS_PER_CAMPAIGN = 20000

	def initialize(opts={})
		opts = {name: "Default Name",
				daily_budget: "10",
				networks: "Search Partners",
				languages: "en",
				bid_strategy_type: "Manual CPC",
				enhanced_cpc: "Disabled",
				viewable_cpm: "Disabled",
				bid_modifier: "-100",
				start_date: Time.now.strftime("%m-%d-%Y"),
				end_date: "[]",
				ad_schedule: "[]",
				location: "United States",
				campaign_status: "Active",
				status: "Active",
				sitelinks: [],
				adgroups: [] }.merge(opts)
		@name = opts[:name]
		@daily_budget = opts[:daily_budget]
		@networks = opts[:networks]
		@languages = opts[:languages]
		@bid_strategy_type = opts[:bid_strategy_type]
		@enhanced_cpc = opts[:enhanced_cpc]
		@viewable_cpm = opts[:viewable_cpm]
		@bid_modifier = opts[:bid_modifier]
		@start_date = opts[:start_date]
		@end_date = opts[:end_date]
		@ad_schedule = opts[:ad_schedule]
		@location = opts[:location]
		@campaign_status = opts[:campaign_status]
		@status = opts[:status]
		@sitelinks = opts[:sitelinks]
		@adgroups = opts[:adgroups]

		@output_row_headers = [ "Campaign",
								"Campaign Daily Budget",
								"Campaign Type",
								"Networks",
								"Languages",
								"Location",
								"Ad Group",
								"Max CPC",
								"Display Network Max CPC",
								"Max CPM",
								"CPA Bid",
								"Display Network Custom Bid Type",
								"Ad Group Type",
								"Flexible Reach",
								"Keyword",
								"ID",
								"Criterion Type",
								"Bid Strategy Type",
								"Bid Strategy Name",
								"Enhanced CPC",
								"Viewable CPM",
								"Bid Modifier",
								"Link Text",
								"Headline",
								"Description Line 1",
								"Description Line 2",
								"App ID / Package name",
								"Display URL",
								"Destination URL",
								"Platform Targeting",
								"Device Preference",
								"Start Date",
								"End Date",
								"Ad Schedule",
								"Campaign Status",
								"AdGroup Status",
								"Status"]
	end

	def createAdGroup(name)
		# Create ad group object
		new_ad_group = AdGroup.new( name: name, 
								  campaign: self)
		@adgroups <<  new_ad_group
		return new_ad_group
	end

	def createSitelink(link_text, desc_line_1, desc_line_2, destination_url)
		@sitelinks << Sitelink.new( campaign: self,
									desc_line_1: desc_line_1,
									desc_line_2: desc_line_2,
									destination_url: destination_url,
									link_text: link_text
									)
	end 

	# Set first to true if it is the first campaign in a set of campaigns that need to be in the same file.
	def outputCampaign(output_filename, first)

		write_options = "wb" if first
		write_options = "a" if not first

		CSV.open(output_filename, write_options, {:encoding => "utf-8", force_quotes: false }) do |csv|
			# Create Headers
			csv << @output_row_headers if first
			# Output Campaign Settings Row
			csv << self.settingsRow

			# Output location row (this must be it's own row for 
			# Mobile Bid adjustment to work in campaign settings row)
			csv << self.locationRow

			# Output All AdGroups Settings Rows
			@adgroups.each do |adgroup|
			 	csv << adgroup.settingsRow
			 	adgroup.keywords.each do |keyword|
			 		csv << keyword.settingsRow
			 	end
			 	adgroup.ads.each do |ad|
			 		csv << ad.settingsRow
			 	end
			end

			# Output All Sitelinks Settings Rows
			@sitelinks.each do |sitelink|
				csv << sitelink.settingsRow
			end

		end
	end

	# Output the location row as an array.
	def locationRow
		output_row = []

		@output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @name
			when "Location"
				output_row << @location
			when "ID"
				output_row << "2840" # AdWords ID code for "United States" location
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end

	# Outputs the settings row as an array
	def settingsRow
		output_row = []
		
		@output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @name
			when "Campaign Daily Budget"
				output_row << @daily_budget
			when "Languages"
				output_row << @languages
			when "Networks"
				output_row << @networks 
			when "Status"
				output_row << @status
			when "Bid Strategy Type"
				output_row << @bid_strategy_type				
			when "Enhanced CPC"
				output_row << @enhanced_cpc
			when "Viewable CPM"
				output_row << @viewable_cpm
			when "Bid Modifier"
				output_row << @bid_modifier
			when "Start Date"
				output_row << @start_date
			when "End Date"
				output_row << @end_date
			when "Ad Schedule"
				output_row << @ad_schedule
			when "Campaign Status"
				output_row << @campaign_status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end

class BingCampaign
	attr_accessor :output_row_headers, :name
	MAX_ADGROUPS_PER_CAMPAIGN = 20000
	TYPE_STRING = "Campaign"

	def initialize(opts={})
		opts = {name: "Default Name",
				budget: "10",
				networks: "Search Partners",
				languages: "en",
				bid_strategy_type: "Manual CPC",
				enhanced_cpc: "Disabled",
				viewable_cpm: "Disabled",
				bid_modifier: "-100",
				start_date: Time.now.strftime("%m-%d-%Y"),
				end_date: "[]",
				ad_schedule: "[]",
				location: "United States",
				campaign_status: "Active",
				status: "Active",
				sitelinks: [],
				adgroups: [] }.merge(opts)

		@output_row_headers = [ "Type",
								"ID",
								"Status",
								"Campaign",
								"Budget",
								"Budget Type",
								"Ad Group",
								"Keyword",
								"Match Type",
								"Bid",
								"Title",
								"Text",
								"Display URL",
								"Destination URL",
								"Time Zone",
								"Keyword Variant Match Type Enabled",
								"Start Date",
								"Search Network",
								"Content Network",
								"Network Distribution",
								"Search Bid",
								"Content Bid",
								"Language",
								"Ad Rotation",
								"Pricing Model",
								"Negative",
								"Target",
								"Physical Intent",
								"Bid Adjustment",
								"Sitelink Extension Order",
								"Sitelink Extension Link Text",
								"Sitelink Extension Destination URL",
								"Sitelink Extension Description1",
								"Sitelink Extension Description2",
								"Name",
								"Device Preference"]
	end

	# Set first to true if it is the first campaign in a set of campaigns that need to be in the same file.
	def outputCampaign(output_filename, first)

		write_options = "wb" if first
		write_options = "a" if not first

		CSV.open(output_filename, write_options, {:encoding => "utf-8", force_quotes: false }) do |csv|
			# Create Headers
			csv << @output_row_headers if first
			# Output Campaign Settings Row
			csv << self.settingsRow

			# Output location row (this must be it's own row for 
			# Mobile Bid adjustment to work in campaign settings row)
			bid_adjustment_rows = self.bidAdjustmentRows
			bid_adjustment_rows.each do |bid_adjustment_row|
				csv << bid_adjustment_row
			end

			# Output All AdGroups Settings Rows
			@adgroups.each do |adgroup|
			 	csv << adgroup.settingsRow
			 	adgroup.keywords.each do |keyword|
			 		csv << keyword.settingsRow
			 	end
			 	adgroup.ads.each do |ad|
			 		csv << ad.settingsRow
			 	end
			end

			# Output All Sitelinks Settings Rows
			@sitelinks.each_with_index do |sitelink, index|
				sitelink.formatVersionRow if index == 0 # Required row by bing to make sure sitelinks work
				sitelink.sharedSettingRow if index == 0 # Required row by bing to tie sitelinks to a campaign
				csv << sitelink.settingsRow
			end

		end
	end

	def createAdGroup(name)
		# Create ad group object
		new_ad_group = BingAdGroup.new( name: name, 
								  campaign: self)
		@adgroups <<  new_ad_group
		return new_ad_group
	end

	def createSitelink(link_text, desc_line_1, desc_line_2, destination_url, id, order_number)
		@sitelinks << BingSitelink.new( campaign: self,
									id: id,
									desc_line_1: desc_line_1,
									desc_line_2: desc_line_2,
									destination_url: destination_url,
									link_text: link_text,
									order_number: order_number
									)
	end 

	# Output the location row as an array.
	def bidAdjustmentRows
		output_rows = []

		adjustment_types = ["Campaign Location Target", "Campaign DeviceOS Target"]
		
		adjustment_types.each do |adjustment_type|

			if adjustment_type == "Campaign Location Target"
				target = "US"
				adjustment_in_percentage = 0
				output_rows << bidAdjustmentRow(adjustment_type, target, adjustment_in_percentage)
			elsif adjustment_type == "Campaign DeviceOS Target"
				device_adjustments = { 'Smartphones' => @mobile_bid_adjustment, 
									   'Tablets' => @tablet_bid_adjustment, 
									   'Computers' => @computers_bid_adjustment }
				device_adjustments.each do |target, adjustment_in_percentage|
					output_rows << bidAdjustmentRow(adjustment_type, target, adjustment_in_percentage)
				end
			end
		end
		
		output_row
	end

	# Output the location row as an array.
	def bidAdjustmentRow(adjustment_type, target, adjustment_in_percentage)
		output_row = []

		@output_row_headers.each do |header|
			case header
			when "Type"
				# adjustment_type = "Campaign Location Target" for location
				# adjustment_type = "Campaign DeviceOS Target" for device
				output_row << adjustment_type
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @name
			when "Target"
				# target = "US" for United states location target
				# target = "Smartphones" for DeviceOS Target to Mobile Phones
				# target = "Tablets" for DeviceOS Target to Tablets
				# target = "Computers" for DeviceOS Target to Computers
				output_row << target
			when "Physical Intent"
				output_row << "PeopleInOrSearchingForOrViewingPages"
			when "Bid Adjustment"
				output_row << adjustment_in_percentage
			when "Name"
				output_row << "United States"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end

	# Outputs the settings row as an array
	def settingsRow
		output_row = []
		
		@output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @name
			when "Budget"
				output_row << @budget 
			when "Budget Type"
				output_row << "DailyBudgetAccelerated"
			when "Time Zone"
				output_row << "PacificTimeUSCanadaTijuana"				
			when "Keyword Variant Match Type Enabled"
				output_row << "TRUE"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end

class Sitelink
	MAX_LINK_TEXT_LENGTH = 25
	MAX_DESCRIPTION_LENGTH = 35
	MAX_DISPLAY_URL_LENGTH = 2048

	def initialize( opts={} )
		opts = {campaign: nil, 
				desc_line_1: "",
				desc_line_2: "",
				destination_url: "",
				link_text: "",
				status: "Active"
			}.merge(opts)
		@campaign = opts[:campaign]
		@desc_line_1 = opts[:desc_line_1]
		@desc_line_2 = opts[:desc_line_2]
		@destination_url = opts[:destination_url]
		@link_text = opts[:link_text]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []
		
		@campaign.output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign.name
			when "Start Date"
				output_row << "[]"
			when "End Date"
				output_row << "[]"
			when "Ad Schedule"
				output_row << "[]"
			when "Description Line 1"
				output_row << @desc_line_1
			when "Description Line 2"
				output_row << @desc_line_2
			when "Destination URL"
				output_row << @destination_url
			when "Device Preference"
				output_row << "All"
			when "Link Text"
				output_row << @link_text
			when "Feed Name"
				output_row << "Main sitelink feed"
			when "Platform Targeting"
				output_row << "All"
			when "Campaign Status"	
				output_row << @campaign.status
			when "Status"
				output_row << @status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end

class BingSitelink
	TYPE_STRING_CAMPAIGN_SITELINK = "Campaign Sitelink Ad Extension"
	TYPE_STRING_SITELINK = "Sitelink Ad Extension"
	MAX_LINK_TEXT_LENGTH = 25
	MAX_DESCRIPTION_LENGTH = 35
	MAX_DISPLAY_URL_LENGTH = 1024

	def initialize( opts={} )
		opts = {campaign: nil,
				id: 0,
				desc_line_1: "",
				desc_line_2: "",
				destination_url: "",
				link_text: "",
				status: "Active",
				order_number: 0
			}.merge(opts)
		@campaign = opts[:campaign]
		@id = opts[:id]
		@desc_line_1 = opts[:desc_line_1]
		@desc_line_2 = opts[:desc_line_2]
		@destination_url = opts[:destination_url]
		@link_text = opts[:link_text]
		@status = opts[:status]
		@order_number = opts[:order_number]
	end

	def formatVersionRow # Required for sitelink imports to work.
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << "Format Version"
			when "Name"
				output_row << "3"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end

	def sharedSettingRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING_CAMPAIGN_SITELINK
			when "ID"
				output_row << @id
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end

	def settingsRow
		output_row = []
		
		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING_SITELINK
			when "ID"
				output_row << @id
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			when "Sitelink Extension Order"
				output_row << @order_number.to_s
			when "Sitelink Extension Link Text"
				output_row << @link_text
			when "Sitelink Extension Destination URL"
				output_row << @destination_url
			when "Sitelink Extension Description1"
				output_row << @desc_line_1
			when "Sitelink Extension Description2"
				output_row << @desc_line_2
			when "Device Preference"
				output_row << "All"
			else
				output_row << nil # Must be nil for CSV to be written properly.
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
	attr_accessor :ads, :keywords, :name, :ad_group_status

	def initialize( opts={} )
		opts = { campaign: nil, 
				 name: "Default AdGroup Name", 
				 keywords: Array[], 
				 ads: Array[], 
				 ad_group_status: "Active"}.merge(opts)

		@campaign = opts[:campaign]
		@name = opts[:name]
		@keywords = opts[:keywords]
		@ads = opts[:ads]
		@ad_group_status = opts[:ad_group_status]
	end

	def createKeyword(keywordString)
		# Create ad group object
		@keywords << Keyword.new( campaign: @campaign,
		 		 				  ad_group: self,
						 		  keyword: keywordString)
	end

	# => createAds - creates ad objects for the campaign based on seed keywords
	def	createAd(headline, desc_line_1, desc_line_2, display_url, destination_url, device_preference)
		@ads << Ad.new( campaign: @campaign,
						ad_group: self,
						headline: headline,
						desc_line_1: desc_line_1,
						desc_line_2: desc_line_2,
						display_url: display_url,
						destination_url: destination_url,
						device_preference: device_preference,
						status: "Active")
	end

	def settingsRow
		output_row = []
		
		@campaign.output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @name
			when "Max CPC"
				output_row << "0.01"
			when "Display Network Max CPC"
				output_row << "0"
			when "Max CPM"
				output_row << "0.25"
			when "CPA Bid"
				output_row << "0.01"
			when "Display Network Custom Bid Type"
				output_row << "None"
			when "Ad Group Type"
				output_row << "Default"
			when "Flexible Reach"
				output_row << "Interests and remarketing"
			when "Campaign Status"
				output_row << @campaign.status
			when "AdGroup Status"
				output_row << @ad_group_status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
	end
end

class BingAdGroup
	attr_accessor :ads, :keywords, :name
	TYPE_STRING = "Ad Group"

	def initialize( opts={} )
		opts = { campaign: nil, 
				 name: "Default AdGroup Name", 
				 keywords: Array[], 
				 ads: Array[], 
				 status: "Active"}.merge(opts)

		@campaign = opts[:campaign]
		@name = opts[:name]
		@keywords = opts[:keywords]
		@ads = opts[:ads]
		@status = opts[:status]
	end

	def createKeyword(keywordString)
		# Create ad group object
		@keywords << BingKeyword.new( campaign: @campaign,
		 		 				  ad_group: self,
						 		  keyword: keywordString)
	end

	# => createAds - creates ad objects for the campaign based on seed keywords
	def	createAd(title, text, display_url, destination_url, device_preference)
		@ads << BingAd.new( campaign: @campaign,
						ad_group: self,
						title: title,
						text: text,
						display_url: display_url,
						destination_url: destination_url,
						device_preference: device_preference )
	end

	def settingsRow
		output_row = []
		
		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @name
			when "Start Date"
				output_row << @start_date
			when "Search Network"
				output_row << "on"
			when "Content Network"
				output_row << "off"
			when "Network Distribution"
				output_row << "OwnedAndOperatedAndSyndicatedSearch"
			when "Search Bid"
				output_row << "0.05"
			when "Content Bid"
				output_row << "0.05"
			when "Language"
				output_row << "English"
			when "Ad Rotation"
				output_row << "OptimizeForClicks"
			when "Pricing Model"
				output_row << "Cpc"
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		output_row
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
	def initialize( opts={} )
		opts = { campaign: nil,
		 		 ad_group: nil,
		 		 max_cpc: 0.50,
		 		 keyword: "",
		 		 type: "Broad",
		 		 device: "All",
		 		 status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@max_cpc = opts[:max_cpc]
		@keyword = opts[:keyword]
		@type = opts[:type]
		@device = opts[:device]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @ad_group.name
			when "Max CPC"
				output_row << @max_cpc
			when "Keyword"
				output_row << @keyword
			when "Criterion Type"
				output_row << @type
			when "Campaign Status"
				output_row << @campaign.status
			when "AdGroup Status"
				output_row << @ad_group.ad_group_status
			when "Status"
				output_row << @status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		return output_row
	end
end

class BingKeyword
	TYPE_STRING = "Keyword"

	def initialize( opts={} )
		opts = { campaign: nil,
		 		 ad_group: nil,
		 		 bid: 0.50,
		 		 keyword: "",
		 		 match_type: "Broad",
		 		 device: "All",
		 		 status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@bid = opts[:bid]
		@keyword = opts[:keyword]
		@match_type = opts[:match_type]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @ad_group.name
			when "Keyword"
				output_row << @keyword
			when "Match Type"
				output_row << @match_type
			when "Bid"
				output_row << @bid
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		return output_row
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
	MAX_AD_HEADLINE_LENGTH = 25
	MAX_AD_DESCRIPTION_LENGTH = 35
	MAX_AD_DISPLAY_URL_LENGTH = 35
	MAX_AD_DESTINATION_URL_LENGTH = 1024

	def initialize( opts={} )
		opts = { campaign: nil,
		  ad_group: nil,
		  headline: "",
		  desc_line_1: "",
		  desc_line_2: "",
		  display_url: "",
		  destination_url: "",
		  device_preference: "All",
		  status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@headline = opts[:headline]
		@desc_line_1 = opts[:desc_line_1]
		@desc_line_2 = opts[:desc_line_2]
		@display_url = opts[:display_url]
		@destination_url = opts[:destination_url]
		@device_preference = opts[:device_preference]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @ad_group.name
			when "Headline"
				output_row << @headline
			when "Description Line 1"
				output_row << @desc_line_1
			when "Description Line 2"
				output_row << @desc_line_2
			when "Display URL"
				output_row << @display_url
			when "Destination URL"
				output_row << @destination_url
			when "Device Preference"
				output_row << @device_preference
			when "Campaign Status"
				output_row << @campaign.status
			when "AdGroup Status"
				output_row << @ad_group.ad_group_status
			when "Status"
				output_row << @status
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		return output_row
	end
end

class BingAd
	# Max Field Lengths (in characters)
	MAX_AD_TITLE_LENGTH = 25
	MAX_AD_TEXT_LENGTH = 71
	MAX_DISPLAY_URL_LENGTH = 35
	MAX_DESTINATION_URL_LENGTH = 1024
	TYPE_STRING = "Text Ad"

	def initialize( opts={} )
		opts = { campaign: nil,
		  ad_group: nil,
		  title: "",
		  text: "",
		  display_url: "",
		  destination_url: "",
		  device_preference: "All",
		  status: "Active"}.merge(opts)
		@campaign = opts[:campaign]
		@ad_group = opts[:ad_group]
		@title = opts[:title]
		@text = opts[:text]
		@display_url = opts[:display_url]
		@destination_url = opts[:destination_url]
		@device_preference = opts[:device_preference]
		@status = opts[:status]
	end

	def settingsRow
		output_row = []

		@campaign.output_row_headers.each do |header|
			case header
			when "Type"
				output_row << TYPE_STRING
			when "Status"
				output_row << @status
			when "Campaign"
				output_row << @campaign.name
			when "Ad Group"
				output_row << @ad_group.name
			when "Title"
				output_row << @title
			when "Text"
				output_row << @text
			when "Display URL"
				output_row << @display_url
			when "Destination URL"
				output_row << @destination_url
			when "Device Preference"
				output_row << @device_preference
			else
				output_row << nil # Must be nil for CSV to be written properly.
			end
		end

		return output_row
	end
end

# Create array to hold all the campaigns once generation is completed
adwordsCampaigns = Array[]
bingCampaigns = []

#Set Niche Parameters
seeds_file_path = "seeds-for-test-import.csv"
seeds = CSV.read(seeds_file_path, :headers => true, :encoding => 'windows-1251:utf-8')

seeds.each do |seed_data|
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
		cityStateCampaignFactory = ModifiedBroadCityStateAdWordsCampaignFactory.new(location_file_path: "city-state-location-data.csv")
		adwordsCampaigns.concat( cityStateCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Adwords City/State Campaign Created"
	end

	if createCity
		cityCampaignFactory = ModifiedBroadCityAdWordsCampaignFactory.new(location_file_path: "city-location-data.csv")
		adwordsCampaigns.concat( cityCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Adwords City Campaign Created"
	end

	# Create Campaign Factory to help with campaign creation
	if createBingCityState
		cityStateCampaignFactory = ModifiedBroadCityStateBingCampaignFactory.new(location_file_path: "city-state-location-data.csv")
		bingCampaigns.concat( cityStateCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Bing City/State Campaign Created"
	end

	if createBingCity
		cityCampaignFactory = ModifiedBroadCityBingCampaignFactory.new(location_file_path: "city-location-data.csv")
		bingCampaigns.concat( cityCampaignFactory.create(seed, short_seed, niche, landingPage, areaOfStudy, concentration) )
		puts seed + " Bing City Campaign Created"
	end
end

#Output the campaigns as a CSV
output_filename = "adwords-campaigns-for-import.csv"
first = true
adWordscampaigns.each_with_index do |campaign, index|
	first = false if index > 0
	ampaign.outputCampaign(output_filename, first)
	puts "Finished writing CSV for " + campaign.name
end

output_filename = "bing-campaigns-for-import.csv"
first = true
bing-campaigns.each_with_index do |campaign, index|
	first = false if index > 0
	ampaign.outputCampaign(output_filename, first)
	puts "Finished writing CSV for " + campaign.name
end


puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"