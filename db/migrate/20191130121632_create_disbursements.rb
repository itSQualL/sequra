# frozen_string_literal: true

class CreateDisbursements < ActiveRecord::Migration[6.0]
  def change
    create_table :disbursements do |t|
      t.belongs_to :merchant, null: false, foreign_key: true, index: true

      t.decimal :amount, null: false, default: 0
      t.integer :week, null: false
      t.integer :year, null: false

      t.timestamps
    end

    add_index :disbursements, %i[merchant_id year week], unique: true
  end
end
