class AddLatlngToStores < ActiveRecord::Migration
  def change
		add_column :stores, :lat, :decimal, precision: 11, scale: 8
		add_column :stores, :lng, :decimal, precision: 11, scale: 8
  end
end
