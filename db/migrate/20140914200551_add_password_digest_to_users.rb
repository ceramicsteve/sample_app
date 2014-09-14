class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string #added a new column to users db with password_digest variable which is a string
    #colon before a variable can be seen as the symbol named as, for pointing to database

  end
end
