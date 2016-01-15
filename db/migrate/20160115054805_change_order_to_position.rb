class ChangeOrderToPosition < ActiveRecord::Migration
  def change
		rename_column :rank_nums, :order, :position
  end
end
