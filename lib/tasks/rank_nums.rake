require 'csv'

namespace :rank_nums do
  desc "create rank_nums"
	task :create, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			1.upto(7).each do |n|
				RankNum.create(
					rank_id: row[0],
					num: row[n],
					special: (n == 1),
					position: n - 1
				)
			end
		end
  end
end

