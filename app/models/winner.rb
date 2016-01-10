class Winner < ActiveRecord::Base
  belongs_to :store
  belongs_to :lottery
end
