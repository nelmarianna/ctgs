class AddChangeColumnToApplication < ActiveRecord::Migration
  def change
  	add_column :applications, :reqChange, :string
  end
end
