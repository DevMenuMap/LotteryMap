class AddDefaultToRankNumsSpecial < ActiveRecord::Migration
  def change
		change_column :rank_nums, :special, :boolean, default: false
  end
end
