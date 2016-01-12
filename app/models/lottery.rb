class Lottery < ActiveRecord::Base
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

	def date_in_ko
		d = date
		d.year.to_s + '년 ' + d.month.to_s + '월 ' + d.day.to_s + '일'
	end
end
