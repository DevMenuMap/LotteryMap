module Naver
  require 'open-uri'
  require 'nokogiri'

	### Constants
	# API keys
	if Rails.env.development?
		MAP_KEY = 'b479fb2352534a9ee7313a9938cda773'
	elsif Rails.env.production?
		MAP_KEY = 'd3f2b047b63329ff39b104ae26860909'
	end
	SEARCH_KEY = '6261e1982f17300eef58a9c8421b0d7d'

	# filters
	FILTER_RULES = [] 

	# coordinates
	KOREA_LAT_RANGE = { min:  33.03, max:  38.63 }
	KOREA_LNG_RANGE = { min: 125.12, max: 131.27 }


	### Instance methods
	# Return array of latitude, longitude 
	def get_latlng
		url = naver_request_url
		xml_page = encode_and_open_xml(url)
		xml_page.remove_namespaces!			# Remove "xmlns:" part.
		xml_finder(xml_page)
	end

	def naver_request_url(options=["utf-8", "latlng"])
		request_url = "http://openapi.map.naver.com/api/geocode.php"
		request_url += "?key=" 			+ MAP_KEY +
									 "&encoding=" + options[0] +
									 "&coord=" 		+ options[1] +
									 "&query=" 		+ self.addr
	end

	def encode_and_open_xml(url)
		Nokogiri::XML(open(URI::encode(url)))
	end

	# Find the "first" nodes for latitude and longitude on Naver xml file.
	def xml_finder(xml_page)
		# Longitude comes first in Naver.
		lng = xml_page.xpath("//item[1]//x").text.to_f
		lat = xml_page.xpath("//item[1]//y").text.to_f
		[lat, lng]
	end

	# Check if coordinates are betweeen valid ranges.
	def valid_latlng?(latlng)
		lat_range = KOREA_LAT_RANGE
		lng_range = KOREA_LNG_RANGE
		latlng[0].between?(lat_range[:min], lat_range[:max]) && latlng[1].between?(lng_range[:min], lng_range[:max])
	end

	# Return array of search result
	def naver_blog_search
		query = short_name + " " + short_addrs
		FILTER_RULES.each do |rule|
			query += " -" + rule
		end
		query = URI.encode("#{query}")

		naver_key = "key=" + SEARCH_KEY
		naver_options = "&query=#{query}&display=5&target=blog&sort=sim"
		naver_url = "http://openapi.naver.com/search?#{naver_key}#{naver_options}"

		items = Nokogiri::XML(open(naver_url)).xpath("//item")
		
		naver_blogs = []
		items.each do |item|
			temp = Hash.new
			temp[:title] = item.xpath("title").text 
			temp[:link]  = item.xpath("link").text
			temp[:description]  = item.xpath("description").text
			temp[:blogger_name] = item.xpath("bloggername").text
			temp[:blogger_link] = item.xpath("bloggerlink").text
			naver_blogs << temp
		end

		naver_blogs
	end
end
