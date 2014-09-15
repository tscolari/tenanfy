module Tenanfy
  class Tenant < ActiveRecord::Base
    validates :name, :themes, presence: true
    validate  :validate_themes
    serialize :configs, Hash
    serialize :themes, Array

    has_many :urls, inverse_of: :tenant

    after_create  :build_schema
    after_destroy :drop_schema

    scope :filter_by_domain, ->(domain) { joins(:urls).where("tenanfy_urls.url" => domain).readonly(false) }

    def self.find_by_domain(host)
      self.filter_by_domain(host).first
    end

    def schema_name
      "tenant_#{id}"
    end

    def switch_to_tenant
      ::Apartment::Tenant.switch(schema_name)
    end

    def theme_paths
      themes.map do |theme|
        "app/views/#{theme}"
      end
    end

    private

    def validate_themes
      themes.each do |theme|
        if theme !~ /[a-z0-9_]+/
          errors.add(:themes, "#{theme} is not in the correct format.")
        end
      end
    end

    def build_schema
      ::Apartment::Tenant.create(schema_name)
    end

    def drop_schema
      ::Apartment::Tenant.drop(schema_name)
    end

  end
end
