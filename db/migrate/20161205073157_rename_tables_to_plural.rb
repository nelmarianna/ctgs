class RenameTablesToPlural < ActiveRecord::Migration
  def change

  	remove_index :applications_conference, :application_id
  	remove_index :applications_conference, :conference_id
  	rename_table :applications_conference, :applications_conferences
  	rename_table :conference, :conferences

	add_index :applications_conferences, :application_id
	add_index :applications_conferences , :conference_id
  end
end
