class Rank < ActiveRecord::Base
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
end
