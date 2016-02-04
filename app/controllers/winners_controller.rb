class WinnersController < ApplicationController
  def index
		@winners = Winner.search(params[:lottery], params[:round])
  end
end
