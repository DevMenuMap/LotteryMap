class RankNum < ActiveRecord::Base
	# Associations
  belongs_to :rank

	# Default scope
	default_scope { order(:rank_id, :order) }
end
