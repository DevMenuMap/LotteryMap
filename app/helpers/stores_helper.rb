module StoresHelper
	def news_pub_date(date)
		DateTime.parse(date).strftime("%Y-%m-%d %H:%M")
	end

	def lotto_ball(n)
		content_tag :div, "#{n}", class: ["ball", ball_color(n)]
	end

	def ball_color(n)
		if n > 40
			"green"
		elsif n > 30
			"black"
		elsif n > 20
			"red"
		elsif n > 10
			"blue"
		else
			"yellow"
		end
	end
end

