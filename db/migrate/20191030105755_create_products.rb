class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :desc
      t.decimal :price
      t.integer :qty
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
