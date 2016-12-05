class AddSupervisorColToUser < ActiveRecord::Migration
  def change
  	add_column :users, :sup_id, :integer
  end
end
