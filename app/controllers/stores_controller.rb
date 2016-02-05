class StoresController < ApplicationController
	before_action :authenticate_user!, except: [:show]

  def index
  end

  def show
		@stores = Store.where(id: params[:id])
		@store = @stores.first
		@rank = @store.rank
		@lottery = @rank.lottery
		@ranks = @lottery.ranks

		respond_to do |format|
			format.html
			format.json { render layout: false }
		end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
