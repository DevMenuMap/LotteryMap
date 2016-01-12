class Store < ActiveRecord::Base
	# Mixins
	include Naver
	
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
	def have_latlng?
		!(lat.nil? || lng.nil? || lat == 0 || lng == 0)
	end
end
