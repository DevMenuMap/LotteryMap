require 'csv'

namespace :lotteries do
  desc "create lotteries"
	task :create, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			Lottery.create(
				category_id: row[0],
				id: row[1],
				round: row[2],
				date: "#{row[3]}-#{row[4]}-#{row[5]}".to_time,
				total_sales: row[6]
			)
		end
	end
end

