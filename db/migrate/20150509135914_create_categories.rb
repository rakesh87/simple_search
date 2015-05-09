class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :reach_count

      t.timestamps
    end

    add_index(:categories, :name)
  end
end
