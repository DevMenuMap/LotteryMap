require 'csv'

namespace :winners do
  desc "create winners"
	task :create, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			Winner.create(
				store_id: row[0],
				rank_id: row[1],
				method: row[2]
			)
		end
  end
end

