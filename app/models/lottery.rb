class Lottery < ActiveRecord::Base
	# mixins
	include ActionView::Helpers::NumberHelper

	# Associations
  belongs_to :category
	has_many :ranks

	# Instance methods
	def name(short = true)
		case category_id
		when 1
			short ? '로또' : '로또(Lotto)'
		when 2 
		'연금복권'
		when 3 
		'스피또500'
		when 4 
		'스피또1000'
		when 5 
		'스피또2000'
		end 
	end

	def sales_in_won
		number_with_delimiter(total_sales) + '원'
	end

	def sales_in_won
		if total_sales >= 10**7
			number_with_delimiter(total_sales) + '원(' + sales_in_ko + ')'
		else
			number_with_delimiter(total_sales) + '원'
		end
	end

	def sales_in_ko
		n = total_sales / 10**7
		if n >= 10
			str = (n / 10).to_s + '억'
			if (m = n % 10) == 0
				str += '원'
			else
				str += ' ' + m.to_s + '천만원'
			end
		elsif n > 0
			n.to_s + '천만원'
		end
	end

	def speeto_num
		case category_id
		when 3
			500
		when 4
			1000
		when 5
			2000
		end
	end

	def date_exists?
		!(date.nil? || date == 0)
	end

	def date_in_ko
		date.year.to_s + '년 ' + date.month.to_s + '월 ' + date.day.to_s + '일'
	end

	def is_lotto?
		category_id == 1
	end

	def is_pension?
		category_id == 2
	end

	def rank(n)
		ranks.where(rank: n)
	end
end
