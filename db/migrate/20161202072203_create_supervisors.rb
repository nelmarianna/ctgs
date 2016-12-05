class CreateSupervisors < ActiveRecord::Migration
  def change
    create_table :supervisors, id:false  do |t|
	  
	  t.integer :supervisor_id, null:false, primary_key: true
	  t.string :employeeNumb, null:false 
	  t.string :grantAccNumb, null:false

      t.timestamps null: false
    end
  end
end
