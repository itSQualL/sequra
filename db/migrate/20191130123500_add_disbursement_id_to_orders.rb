# frozen_string_literal: true

class AddDisbursementIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :disbursement, index: true
  end
end
