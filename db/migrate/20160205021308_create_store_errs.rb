class CreateStoreErrs < ActiveRecord::Migration
  def change
    create_table :store_errs do |t|
      t.references :store, index: true, foreign_key: true
      t.string :email
      t.string :content

      t.timestamps null: false
    end
  end
end
