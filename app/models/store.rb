require 'net/http'

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

	def self.last_updated_at
		limit(1).order(updated_at: :desc).pluck(:updated_at)[0]
	end

	def self.ping(offset)
		header = {
			"User-agent" => "request",
			"Host" => "apis.naver.com",
			"Progma" => "no-cache",
			"Content-type" => "application/x-www-form-urlencoded",
			"Accept" => "*/*",
			"Authorization" => "Bearer " + Naver::SYNDICATION_KEY
		}

		uri = URI.parse('https://apis.naver.com/crawl/nsyndi/v2')

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		atom_url = 'http://lotterymap.co.kr/sitemap.atom?offset=' + offset.to_s

		args = { ping_url: atom_url }
		uri.query = URI.encode_www_form(args)

		request = Net::HTTP::Post.new(uri.request_uri, header)
		puts http.request(request)
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

	def short_addr
		addr.split[0..2].join(' ')
	end
end
