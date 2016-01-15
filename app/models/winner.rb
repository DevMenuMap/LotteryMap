class Winner < ActiveRecord::Base
	# Associations
  belongs_to :store
  belongs_to :rank
end
