# This migration comes from tenantfy (originally 20130128025755)
class CreateTenantfyUrls < ActiveRecord::Migration
  def change
    create_table :tenantfy_urls do |t|
      t.string     :url   , null: false
      t.references :tenant, null: false
      t.timestamps
    end
    add_index :tenantfy_urls, :tenant_id
    add_index :tenantfy_urls, :url, unique: true
  end
end
