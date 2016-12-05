class CreateJoinTableSupervisorsRequesters < ActiveRecord::Migration
  def change
    create_join_table :supervisors, :requesters, id:false do |t|
       t.index :supervisor_id
      t.index :requester_id
    end
  end
end
