class ColumnNameRefraction < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :qty, :quantity
    rename_column :products, :desc, :description
  end
end
