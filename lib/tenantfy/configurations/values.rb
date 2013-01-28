module Tenantfy
  module Configurations
    # These are constant key names for the tenant configurations.
    # The values for each of these keys must be set (if used) in
    # Tenantfy::Tenant.configurations
    module Values
      # Comment possible values
      COMMENT_FACEBOOK = 'facebook'
      COMMENT_DISQUS   = 'disqus'
      COMMENT_LIVEFYRE = 'livefyre'
    end
  end
end
