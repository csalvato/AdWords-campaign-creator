require './CampaignFactory.rb'
require './AdWordsCampaign.rb'
require './AdWordsSitelink.rb'
require './AdWordsAdGroup.rb'
require './AdWordsKeyword.rb'
require './AdWordsAd.rb'

class AdWordsCampaignFactory < CampaignFactory

	def createCampaignSitelinks(current_campaign, niche, seed, short_seed, landingPage, area_of_study, concentration)
		sitelink_page_headline = "Looking for " + seed + "?"
		sitelink_utm_campaign = "_src*adwords-sitelink_d*{ifmobile:mb}{ifnotmobile:dt}_k*{keyword}_m*{matchtype}_c*{creative}_p*{adposition}_n*{network}"
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
							  		  "Quick " + short_seed + " Finder",
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