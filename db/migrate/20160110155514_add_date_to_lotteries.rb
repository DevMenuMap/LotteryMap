class AddDateToLotteries < ActiveRecord::Migration
  def change
		add_column :lotteries, :date, :datetime
  end
end
