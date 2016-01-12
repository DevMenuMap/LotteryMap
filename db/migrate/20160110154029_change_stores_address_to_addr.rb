class ChangeStoresAddressToAddr < ActiveRecord::Migration
  def change
		rename_column :stores, :addresss, :addr
  end
end
