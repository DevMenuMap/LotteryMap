class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.references :store, index: true, foreign_key: true
      t.references :lottery, index: true, foreign_key: true
      t.integer :method

      t.timestamps null: false
    end
  end
end
