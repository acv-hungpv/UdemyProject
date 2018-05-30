class AddColumnLevelToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :level, :integer, limit: 1
  end
end
