class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.references :lottery, index: true, foreign_key: true
      t.integer :rank
      t.integer :total_winners
      t.bigint :winning

      t.timestamps null: false
    end
  end
end
