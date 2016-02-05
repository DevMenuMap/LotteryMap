class Winner < ActiveRecord::Base
	# Associations
  belongs_to :store
  belongs_to :rank

	# Class methods
	def self.search(lottery, round)
		n = (lottery_name_to_id(lottery) * 10000 + round.to_i) * 100
		query = <<-SQL 
			SELECT w.*
			FROM winners w
			LEFT JOIN ranks r
			ON w.rank_id = r.id
			WHERE r.id > #{n}
			AND		r.id < #{n + 100} 
		SQL

		find_by_sql(query)
	end

	def self.lottery_name_to_id(name)
		case name
		when "로또"
			1
		when "연금복권"
			2
		when "스피또500"
			3
		when "스피또1000"
			4
		when "스피또2000"
			5
		end
	end
end
