class CreateJoinTableApplicationsRequesters < ActiveRecord::Migration
  def change
    create_join_table :applications, :requesters, id:false do |t|
 
       t.index :application_id
      t.index :requester_id
    end
  end
end
