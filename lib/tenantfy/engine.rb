module Tenantfy
  class Engine < ::Rails::Engine
    isolate_namespace Tenantfy

    initializer "tenantfy.include_helpers" do |app| 
      ActionController::Base.helper ::Tenantfy::Helpers
    end
  end
end
