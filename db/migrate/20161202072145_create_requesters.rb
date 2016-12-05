class CreateRequesters < ActiveRecord::Migration
  def change
    create_table :requesters, id:false do |t|

	 t.integer :requester_id, null:false, primary_key: true
	t.string :studNumb, null:false
	 t.string :academicUnit, null:false
	t.string :program, null:false
	t.string :sessionNumber, null:false
	t.string :thesisTopic, null:false
	t.string :bankAccNumber, null:false

      t.timestamps null: false
    end
  end
end
