class ChangeUserPrimaryKeyStart < ActiveRecord::Migration
  def change
  	execute "SELECT setval('users_user_id_seq', 2)"
  end
end
