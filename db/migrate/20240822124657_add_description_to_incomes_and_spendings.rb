# frozen_string_literal: true

class AddDescriptionToIncomesAndSpendings < ActiveRecord::Migration[7.0]
  def change
    add_column :incomes, :description, :string
    add_column :spendings, :description, :string
  end
end
