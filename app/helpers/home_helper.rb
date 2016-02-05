module HomeHelper
	def round(n)
		n.to_s + '회'
	end

	def simple_time_form(time)
		time.strftime("%Y-%m-%d %H시 %M분")
	end
end
