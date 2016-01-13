module StoresHelper
	def news_pub_date(date)
		DateTime.parse(date).strftime("%Y-%m-%d %H:%M")
	end
end

