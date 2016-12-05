class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications, id:false do |t|
	
	 t.integer :application_id, null:false, primary_key: true
	 t.string :status, null:false
	 t.integer :registration, null:false	 
	 t.integer :transportation, null:false
	 t.integer :accommodation, null:false
	 t.integer :meals, null:false
	 t.string :presentationType, null:false
	 t.string :presentationTitle, null:false


      t.timestamps null: false
    end
  end
end
