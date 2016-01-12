require 'csv'

namespace :stores do
  desc "create stores"
	task :create, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			Store.create(
				id: row[0],
				name: row[1],
				addr: row[2]
			)
		end
  end
end

