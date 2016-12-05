class CreateConferenceDetails < ActiveRecord::Migration
  def change
    create_table :conference_details, id:false do |t|

 	t.integer :conference_id, null:false, primary_key: true
	t.date :startDate, null:false
	t.date :endDate, null:false
	t.string :website, null:false
	t.string :location, null:false

      t.timestamps null: false
    end
  end
end
