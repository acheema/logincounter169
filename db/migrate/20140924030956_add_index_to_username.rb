class AddIndexToUsername < ActiveRecord::Migration
  def change
  	add_index :users, :user, unique: true
  end
end
