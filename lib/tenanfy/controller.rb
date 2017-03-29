module Tenanfy
  module Controller
    extend ActiveSupport::Concern

    included do
      around_action :setup_tenant_thread
      helper_method :current_tenant, :current_tenant_themes, :current_tenant_name
      helper_method :current_tenant_themes
      helper_method :current_tenant_theme
      helper_method :current_tenant_name
    end

    private

    # Setups the current_tenant in the RequestStore.store
    # so it can be accessed by different contexts in the
    # same request
    #
    # ensures that it will be set to nil after the request
    # this way there isn't any dead tenant hanging
    #
    def setup_tenant_thread
      RequestStore.store[:tenant] = current_tenant
      on_tenant_change
      prepend_tenant_themes
      yield
    ensure
      after_tenant_change
      RequestStore.store[:tenant] = nil
    end

    # Adds the tenant themes in the controller view path
    def prepend_tenant_themes
      return unless current_tenant && current_tenant.theme_paths
      prepend_view_path current_tenant.theme_paths
    end

    # Returns the current tenant for this request
    def current_tenant
      @current_tenant ||= Tenant.find_by_domain(request.host)
    end

    def current_tenant_theme
      current_tenant_themes.first.to_s
    end

    # Returns the current tenant themes
    def current_tenant_themes
      current_tenant ? current_tenant.themes : []
    end

    # Returns the current tenant name
    def current_tenant_name
      current_tenant ? current_tenant.name : "Global"
    end

    def on_tenant_change; end
    def after_tenant_change; end
  end
end
