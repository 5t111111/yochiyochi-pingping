class CreateWebApps < ActiveRecord::Migration
  def change
    create_table :web_apps do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
