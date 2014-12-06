class RenameWebAppsToWebsites < ActiveRecord::Migration
  def change
    rename_table :web_apps, :websites
  end
end
