module Daum
	require 'open-uri'
	require 'nokogiri'

	### Constants
	# API keys
	JS_KEY = '9d3e2f4fe81ac3253bff2bb6437a5b6a'


	### Instance methods
	def daum_blog_search
		query = search_query
		query = URI.encode("#{query}")

		daum_key = "?apikey=" + JS_KEY
		daum_options = "&q=#{query}&output=xml&result=5&sort=accu&advance=n" 
		daum_url = "http://apis.daum.net/search/blog#{daum_key}#{daum_options}"
																				 
		items = Nokogiri::XML(open(daum_url)).xpath("//item")
		
		daum_blogs = []
		items.each do |item|
			temp = Hash.new
			temp[:title] = item.xpath("title").text 
			temp[:link]  = item.xpath("link").text
			temp[:description]  = item.xpath("description").text
			temp[:blogger_name] = item.xpath("author").text
			temp[:blogger_link] = item.xpath("comment").text
			daum_blogs << temp
		end

		daum_blogs
	end
end
