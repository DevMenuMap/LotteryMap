class StoreErr < ActiveRecord::Base
	# Associations
  belongs_to :store

	# Scopes
	default_scope { where(active: true) }

	# Validations
	validates :content, presence: true
end
