class UpdatingRecipes < ActiveRecord::Migration[7.0]
  def change
    change_table :recipes do |t|
      t.belongs_to :user
    end
  end
end
