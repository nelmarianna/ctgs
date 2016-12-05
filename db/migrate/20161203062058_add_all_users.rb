class AddAllUsers < ActiveRecord::Migration
  def change
  	
  	add_column :users, :grantAccNumb, :string
  	add_column :users, :employeeNumb, :string
  	add_column :users, :studNumb, :string
  	add_column :users, :academicUnit, :string
  	add_column :users, :program, :string
  	add_column :users, :sessionNumber, :string
  	add_column :users, :thesisTopic, :string
  	add_column :users, :bankAccNumb, :string

  end
end
