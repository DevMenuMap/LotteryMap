class PortalsController < ApplicationController
  def news
		@store = Store.find(params[:id])
		# {:title, :link, :description, :pub_date}
		@naver_news = @store.search_naver

		respond_to do |format|
			format.js
		end
  end
end
