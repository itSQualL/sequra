# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[6.0]
  def change
    create_table :merchants do |t|
      t.string :cif, null: false, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.string :name, null: false

      t.timestamps
    end
  end
end
