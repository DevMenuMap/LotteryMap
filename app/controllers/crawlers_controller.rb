class CrawlersController < ApplicationController
	layout nil

  def google
		@url = 'http://lotterymap.co.kr/'
		@stores = Store.where("updated_at > NOW() - INTERVAL 7 DAY")
		@lotteries = Lottery.all

		respond_to do |format|
			format.xml
		end
  end

	def naver
  	@stores = Store.limit(100).offset(params[:offset].to_i)

		respond_to do |format|
			format.atom
		end
	end
end
