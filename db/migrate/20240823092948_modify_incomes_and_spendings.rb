# frozen_string_literal: true

class ModifyIncomesAndSpendings < ActiveRecord::Migration[7.0]
  def change
    # Usuwanie kolumn month i year
    remove_column :incomes, :month, :integer
    remove_column :incomes, :year, :integer
    remove_column :spendings, :month, :integer
    remove_column :spendings, :year, :integer

    # Dodawanie nowej kolumny date
    add_column :incomes, :date, :date
    add_column :spendings, :date, :date
  end
end
