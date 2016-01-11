class Rank < ActiveRecord::Base
  belongs_to :lottery
	has_many :rank_nums
end
