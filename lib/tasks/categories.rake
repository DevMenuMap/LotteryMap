require 'csv'

namespace :categories do
  desc "create categories"
	task :create, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			Category.create(
				id: row[0],
				name: row[1]
			)
		end
  end
end

