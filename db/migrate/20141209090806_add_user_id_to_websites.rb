class AddUserIdToWebsites < ActiveRecord::Migration
  def change
    add_reference :websites, :user, index: true
    add_foreign_key :websites, :users
  end
end
