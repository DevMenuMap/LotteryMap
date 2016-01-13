namespace :crawlers do
  desc "send ping to naver"
  task :naver_ping, [:start] => :environment do |t, args|
		args.with_default(start: nil)

		# when there is an argument
		if args.start
			args.start.split.each do |n|
				offset = n.to_i * 100
				Store.ping(offset)
			end
		# when there is no argument, ping every stores
		else
			total = Store.count
			total % 100 == 0 ? max = (total / 100) - 1 : max = (total / 100)

			0.upto(max).each do |n|
				offset = n * 100
				Store.ping(offset)
				sleep 3 # Pause for 3 seconds.
			end
		end
	end
end
