# This migration comes from tenanfy (originally 20130128025755)
class CreateTenanfyUrls < ActiveRecord::Migration
  def change
    create_table :tenanfy_urls do |t|
      t.string     :url   , null: false
      t.references :tenant, null: false
      t.timestamps
    end
    add_index :tenanfy_urls, :tenant_id
    add_index :tenanfy_urls, :url, unique: true
  end
end
