class WinnersController < ApplicationController
  def index
		@winners = Winner.search(params[:lottery], params[:round])

		respond_to do |format|
			format.html
			format.json { render layout: false }
		end
  end
end
