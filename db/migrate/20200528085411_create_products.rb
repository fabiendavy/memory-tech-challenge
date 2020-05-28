class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code
      t.string :description
      t.float :unit_price

      t.timestamps
    end
  end
end
