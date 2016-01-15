class HomeController < ApplicationController
	include ActionView::Helpers::NumberHelper

  def index
  end

	def stat
		cat_lotto = 1
		@total = total(cat_lotto)
		@sum_of_xth = [[], [], [], [], []]
		@avg_of_xth = []
		@max_of_xth = []

		for i in 0..4
			foo = xth_sum(cat_lotto, i+1)
			@avg_of_xth[i] = 
				number_with_delimiter(foo[:total] / foo[:winner] / Category.find(cat_lotto).lotteries.size)
			@sum_of_xth[i] = 
				[number_with_delimiter(foo[:winner]), number_with_delimiter(foo[:total])]
			@max_of_xth[i] = [number_with_delimiter(foo[:max]), foo[:max_round]]
		end
	end

	# only for Lotto
	def total(cat_id)
		sum = max = max_round = 0
		Lottery.where(category_id: cat_id).each do |l|
			sum += l.total_sales
			if max < l.total_sales
				max = l.total_sales
				max_round = l.round
			end
		end
		return { sum: number_with_delimiter(sum), max: number_with_delimiter(max), max_round: max_round }
	end

	def xth_sum(cat_id, xth)
		winning = winner = max_winning = 0
		round = 0
		Lottery.where(category_id: cat_id).each do |l| # for each round
			l.ranks.where(rank: xth).each do |r|
				winning += r.winning
				winner += r.total_winners
				if max_winning < r.winning
					max_winning = r.winning
					round = l.round
				end
			end
		end
		return { winner: winner, total: winning * winner, max: max_winning, max_round: round }
	end
end
