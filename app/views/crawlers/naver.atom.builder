naver_atom_feed({ xmlns: "http://webmastertool.naver.com",
									id: 'http://lotterymap.co.kr'}) do |feed|
	feed.title(basic_meta_title)
	feed.author do |a|
		a.name("LotteryMap")
		a.url("http://lotterymap.co.kr")	# optional
		a.email("dev@lotterymap.co.kr")		# optional 
	end
	feed.updated(feed_updated_at(@stores))
	feed.link(rel: 'site', href: 'http://lotterymap.co.kr', 
						title: 'LotteryMap')

	@stores.each do |store|
		feed.naver_entry(store, { id: store_url(store) }) do |entry|
			entry.title(store_meta_title(store))
			entry.author { |a| a.name(store.name) }
			entry.updated(store.updated_at.xmlschema)
			entry.published(store.created_at.xmlschema)
			# from which url
			# entry.link(rel: 'via', href: 'http://lotterymap.co.kr/search')
			entry.link(rel: 'via', href: 'http://lotterymap.co.kr')
			entry.content(store_meta_description(store), type: 'html')
		end
	end
end

