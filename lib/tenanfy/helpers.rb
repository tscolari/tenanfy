module Tenanfy
  module Helpers
    #extend ActiveSupport::Concern

    # Appends the tenant theme to the source if not a full-path
    # or url
    def tenant_stylesheet_link_tag(*sources)
      new_sources = append_tenant_theme_to_assets(*sources)
      stylesheet_link_tag(*new_sources)
    end

    # Appends the tenant theme to the source if not a full-path
    # or url
    def tenant_javascript_include_tag(*sources)
      new_sources = append_tenant_theme_to_assets(*sources)
      javascript_include_tag(*new_sources)
    end

    private

    # updates the asset list with tenant theme where it's
    # necessary
    #
    def append_tenant_theme_to_assets(*assets)
      assets.map! do |asset|
        should_add_tenant_theme_to_asset?(asset) && current_tenant ? "#{current_tenant.theme}/#{asset}" : asset
      end
      assets
    end

    # Returns false if the asset is a full-path or url
    # true for everything else
    def should_add_tenant_theme_to_asset?(asset)
      if asset.is_a? String
        return true if (! asset.match /^http:\/\//) && (! asset.match /^\//)
      end
      false
    end

  end
end
