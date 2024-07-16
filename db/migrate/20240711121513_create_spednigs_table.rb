class CreateSpednigsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :spendings do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.integer :user_id
      t.integer :month
      t.integer :year
      t.string :kind

      t.timestamps
    end

    add_index :spendings, :user_id
  end
end
