class CreateIncomeTable < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.integer :user_id
      t.integer :month
      t.integer :year

      t.timestamps
    end

    add_index :incomes, :user_id
  end
end
