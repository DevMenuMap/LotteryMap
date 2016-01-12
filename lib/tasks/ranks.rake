require 'csv'

namespace :ranks do
  desc "create ranks and rank_nums"
	task :create, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			r = Rank.create(
				id: row[0],
				lottery_id: row[1],
				rank: row[2],
				total_winners: row[3],
				winning: row[4]
			)

			5.upto(11).each do |n|
				if row[n]
					r.rank_nums.create(
						num: row[n],
						special: (n == 11),
						order: (n == 11 ? nil : n - 5)
					)
				else
					break
				end
			end
		end
  end
end

