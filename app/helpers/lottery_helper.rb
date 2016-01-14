module LotteryHelper
	def lottery_name_title(lottery)
		if lottery.is_lotto?
			lotto_title
		elsif lottery.is_pension?
			pension_title	
		else
			speeto_title(lottery.speeto_num)
		end
	end

	def lotto_title
		concat content_tag :span, '로또 L', class: 'lottery_blue'
		concat content_tag :span, 'o', class: 'lotto_sky_blue'
		concat content_tag :span, 'tt', class: 'lottery_blue'
		content_tag :span, 'o', class: 'lottery_green'
	end

	def pension_title
		concat content_tag :span, '연금복권', class: 'lottery_blue'
		content_tag :span, '520', class: 'lottery_green'
	end

	def speeto_title(n)
		concat content_tag :span, '스피또', class: 'lottery_blue'
		content_tag :span, "#{n}", class: 'speeto_orange'
	end

	def lotto_sales_period(lottery)
		(lottery.date - 1.week).strftime("%Y/%m/%d") + ' ~ ' + lottery.date.strftime("%Y/%m/%d") 
	end
end
