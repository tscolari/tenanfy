# This migration comes from tenanfy (originally 20130128025640)
class CreateTenanfyTenants < ActiveRecord::Migration
  def change
    create_table :tenanfy_tenants do |t|
      t.string :name  , null: false
      t.string :themes, null: false, array: true, default: '{}'
      t.string :description
      t.string :keywords
      t.text   :configs
      t.timestamps
    end
  end
end
