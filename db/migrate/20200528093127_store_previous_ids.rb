class StorePreviousIds < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :previous_id, :integer
    add_column :customers, :previous_id, :integer
  end
end
