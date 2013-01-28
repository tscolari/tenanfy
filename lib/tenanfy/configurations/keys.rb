module Tenanfy
  module Configurations
    # These are constant key names for the tenant configurations.
    # The values for each of these keys must be set (if used) in
    # Tenanfy::Tenant.configurations
    module Keys
      # Holds what kind of comment the tenant uses
      COMMENT_TYPE = 'comment_type'

      # FACEBOOK configuration 
      FACEBOOK_APP_ID     = 'facebook_app_id'
      FACEBOOK_APP_SECRET = 'facebook_app_secret'

      # DISQUS configuration
      DISQUS_SHORT_NAME = 'disqus_name'

      # LIVEFYRE configuration
      LIVEFYRE_SITE_ID = 'livefyre_id'
    end
  end
end
