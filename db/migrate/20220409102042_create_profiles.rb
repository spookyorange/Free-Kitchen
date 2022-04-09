class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :username

      t.timestamps
    end

    remove_belongs_to :recipes, :user
    add_belongs_to :recipes, :profile
    remove_column :users, :username
  end
end
