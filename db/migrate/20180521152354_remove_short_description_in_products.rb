class RemoveShortDescriptionInProducts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :products, :short_description, :string
  end
end
