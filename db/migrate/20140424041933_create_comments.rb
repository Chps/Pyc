class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
    add_index :comments, [:created_at]
  end
end
