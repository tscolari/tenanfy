# This migration comes from tenantfy (originally 20130128025640)
class CreateTenantfyTenants < ActiveRecord::Migration
  def change
    create_table :tenantfy_tenants do |t|
      t.string :name  , null: false
      t.string :theme , null: false
      t.string :description
      t.string :keywords
      t.text   :configs
      t.timestamps
    end
  end
end
