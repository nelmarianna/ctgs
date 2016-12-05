class CreateJoinTableConferenceDetailsApplication < ActiveRecord::Migration
  def change
    create_join_table :conference, :applications, id:false do |t|
       t.index :conference_id
       t.index :application_id
    end
  end
end
