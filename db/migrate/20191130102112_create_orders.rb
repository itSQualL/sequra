# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :merchant, null: false, index: true
      t.belongs_to :shopper, index: true

      t.decimal :amount, null: false
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
