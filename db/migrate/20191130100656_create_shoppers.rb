# frozen_string_literal: true

class CreateShoppers < ActiveRecord::Migration[6.0]
  def change
    create_table :shoppers do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :nif, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
