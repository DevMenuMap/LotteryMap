class AddAroundToStores < ActiveRecord::Migration
  def change
    add_column :stores, :around, :boolean, default: false
  end
end
