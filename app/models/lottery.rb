class Lottery < ActiveRecord::Base
	# Associations
  belongs_to :category
	has_many :ranks

	# Instance methods
	def name
		case category_id
		when 1
		'로또'
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
end
