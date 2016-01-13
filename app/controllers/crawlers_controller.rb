class CrawlersController < ApplicationController
	layout nil

  def google
		@url = 'http://lotterymap.co.kr/'
		@stores = Store.all

		respond_to do |format|
			format.xml
		end
  end
end
