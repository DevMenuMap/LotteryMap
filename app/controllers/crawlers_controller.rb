class CrawlersController < ApplicationController
	layout nil

  def google
		@url = 'http://lotterymap.co.kr/'
		@stores = Store.all.limit(10)

		respond_to do |format|
			format.xml
		end
  end
end
