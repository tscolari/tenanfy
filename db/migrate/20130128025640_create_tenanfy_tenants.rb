class CreateTenanfyTenants < ActiveRecord::Migration
  def change
    create_table :tenanfy_tenants do |t|
      t.string :name  , null: false
      t.string :theme , null: false
      t.string :description
      t.string :keywords
      t.text   :configs
      t.timestamps
    end
  end
end
