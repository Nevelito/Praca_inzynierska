class CreateGoalPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :goal_payments do |t|
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.date :payment_date, null: false
      t.references :goal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
