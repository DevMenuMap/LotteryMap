class Rank < ActiveRecord::Base
	# mixins
	include ActionView::Helpers::NumberHelper

	# Associations
  belongs_to :lottery
	has_many :rank_nums
	has_many :stores, through: :winners
	has_many :winners

	# Instance methods
	def round_in_ko
		lottery.round.to_s + '회'
	end

	def rank_in_ko
		rank.to_s + '등'
	end

	def winning_in_won(short = false)
		if is_pension? && rank == 1
			"20년 매월 &#8361; 500만원".html_safe
		elsif winning < 10**7 || short
			number_with_delimiter(winning) + '원'
		else
			number_with_delimiter(winning) + '원(' + winning_in_ko + ')'
		end
	end

	def winning_in_ko
		n = winning / 10**7
		if n >= 10
			str = (n / 10).to_s + '억'
			if (m = n % 10) == 0
				str += '원'
			else
				str += ' ' + m.to_s + '천만원'
			end
		elsif n > 0
			n.to_s + '천만원'
		end
	end

	def total_winning_in_won
		number_with_delimiter(winning * total_winners) + '원'
	end

	def winners_in_ko
		number_with_delimiter(total_winners) + '명'
	end

	def is_pension?
		id > 2000000 && id < 3000000
	end
end
