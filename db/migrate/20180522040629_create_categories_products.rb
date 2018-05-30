class CreateCategoriesProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_products do |t|
    	t.references :category, index: true
    	t.references :product, index: true
    end
  end
end
