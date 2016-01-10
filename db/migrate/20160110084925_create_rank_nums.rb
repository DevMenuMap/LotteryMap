class CreateRankNums < ActiveRecord::Migration
  def change
    create_table :rank_nums do |t|
      t.references :rank, index: true, foreign_key: true
      t.integer :num
      t.boolean :special
      t.integer :order

      t.timestamps null: false
    end
  end
end
