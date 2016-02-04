class Lottery < ActiveRecord::Base
	# mixins
	include ActionView::Helpers::NumberHelper

	# Associations
  belongs_to :category
	has_many :ranks

	# Class methods
	def self.category_params(params)
		case params
		when "로또"
			where("category_id = 1")
		when "연금복권"
			where("category_id = 2")
		when "스피또500"
			where("category_id = 3")
		when "스피또1000"
			where("category_id = 4")
		when "스피또2000"
			where("category_id = 5")
		end
	end

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
		number_with_delimiter(total_sales) + '원(' + sales_in_ko + ')'
	end

	def sales_in_ko
		n = total_sales / 10**8
		n.to_s + '억'
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
