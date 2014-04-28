class AddMultipleIndexes < ActiveRecord::Migration
  def change
    add_index :comments, :image_id
    add_index :comments, :user_id
    add_index :impressions, :created_at
    add_index :users, :country
    add_index :users, :birthdate
  end
end
