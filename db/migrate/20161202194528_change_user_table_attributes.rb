class ChangeUserTableAttributes < ActiveRecord::Migration
  def change

	  remove_column :users, :id
	  add_column :users, :user_id, :primary_key

	add_column :users, :loginID, :string, null:false
	add_column :users, :type, :string, null:false
	add_column :users, :firstName, :string, null:false, limit: 30
	add_column :users, :lastName, :string, null:false, limit: 30


	 rename_table :conference_details, :conference
  end
end
