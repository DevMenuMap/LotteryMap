class HomeController < ApplicationController
  def index
		@categories = Category.all
		@rounds = Lottery.pluck(:round).uniq.reverse
  end
end
