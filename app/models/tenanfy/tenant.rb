module Tenanfy
  class Tenant < ActiveRecord::Base
    validates       :name, :theme, presence: true
    validates       :theme, format: { with: /[a-z0-9_]+/ }
    serialize       :configs, Hash

    has_many :urls, inverse_of: :tenant

    after_create  :build_schema
    after_destroy :drop_schema

    scope :filter_by_domain, ->(domain) { joins(:urls).where("tenanfy_urls.url" => domain).readonly(false) }

    def self.find_by_domain(host)
      self.filter_by_domain(host).first
    end

    def schema_name
      "tenant_#{self.id}"
    end

    def switch_to_tenant
      ::Apartment::Tenant.switch(self.schema_name)
    end

    def theme_path
      "app/views/#{self.theme}"
    end

    private

    def build_schema
      ::Apartment::Tenant.create(self.schema_name)
    end

    def drop_schema
      ::Apartment::Tenant.drop(self.schema_name)
    end

  end
end
