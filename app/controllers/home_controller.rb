class HomeController < ApplicationController
  def index
		@categories = Category.all
		@rounds = Lottery.where("category_id = 1").pluck(:round).reverse
  end

	def change_rounds
		@rounds = Lottery.category_params(params[:lottery]).pluck(:round).reverse
		respond_to do |format|
			format.js { render layout: false }
		end
	end
end
