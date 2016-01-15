module StoresHelper
	include ActionView::Helpers::NumberHelper

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

	def pension_multiplier(num, multiplier)
		number_with_delimiter(num * multiplier)
	end

	def special_number(rank)
		n = rank.rank_nums.find_by_special(true).num
		if n.nil?
			'각조'
		else
			n.to_s + '조'
		end
	end

	def number_or_blank(rank_num)
		rank_num.num.nil? ? '-' : rank_num.num
	end
end

