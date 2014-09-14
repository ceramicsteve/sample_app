class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index( :users, :email, unique: true)# adds index to user and email columns with enforcement of each index is unique


  end
end
