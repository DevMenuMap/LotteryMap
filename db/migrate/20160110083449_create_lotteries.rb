class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.references :category, index: true, foreign_key: true
      t.integer :round
      t.timestamps :date
      t.bigint :total_sales

      t.timestamps null: false
    end
  end
end
