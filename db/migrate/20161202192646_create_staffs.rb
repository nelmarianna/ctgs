class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs, id:false do |t|

	t.integer :staff_id, null:false, primary_key: true
	t.string :employeeNumb, null:false 

      t.timestamps null: false
    end
  end
end
