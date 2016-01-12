class Store < ActiveRecord::Base
	# Mixins
	include Naver
	include Daum

	# Associations
	has_many :winners
	has_many :ranks, through: :winners
	
	# Class methods
	def self.save_latlng
		self.without_latlng.each do |r|
			latlng = r.get_latlng
			r.update(lat: latlng[0], lng: latlng[1])
		end
	end

	def self.without_latlng
		where("lat IS NULL OR lng IS NULL")
	end

	# Instance methods
	def rank
		ranks.first
	end

	def have_latlng?
		!(lat.nil? || lng.nil? || lat == 0 || lng == 0)
	end

	# use with naver, daum search API
	def search_query
		[rank.lottery.name, rank.round_in_ko, rank.rank_in_ko, '당첨'].join(' ')
	end
end
