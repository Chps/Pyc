class AddBioToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text, limit: 500
  end
end
