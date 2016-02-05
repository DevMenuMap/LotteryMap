class AddActiveToStoreErrs < ActiveRecord::Migration
  def change
		add_column :store_errs, :active, :boolean, default: true
  end
end
