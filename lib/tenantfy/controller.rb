module Tenantfy
  module Controller
    extend ActiveSupport::Concern

    included do
      around_filter :setup_tenant_thread
      helper_method :current_tenant, :current_tenant_theme, :current_tenant_name
    end

    private

    # Setups the current_tenant in the Thread.current
    # so it can be accessed by different contexts in the
    # same request
    #
    # ensures that it will be set to nil after the request
    # this way there isn't any dead tenant hanging
    #
    def setup_tenant_thread
      Thread.current[:tenant] = current_tenant
      prepend_tenant_theme
      yield
    ensure
      Thread.current[:tenant] = nil
    end

    # Adds the tenant theme in the controller view path
    def prepend_tenant_theme
      prepend_view_path current_tenant.theme_path if current_tenant
    end

    # Returns the current tenant for this request
    def current_tenant
      @current_tenant ||= Tenant.find_by_domain(request.host)
    end

    # Returns the current tenant theme
    def current_tenant_theme
      current_tenant ? current_tenant.theme : ""
    end

    # Returns the current tenant name
    def current_tenant_name
      current_tenant ? current_tenant.name : "Global"
    end

  end
end
