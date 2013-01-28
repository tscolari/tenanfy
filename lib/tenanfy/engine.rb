module Tenanfy
  class Engine < ::Rails::Engine
    isolate_namespace Tenanfy

    initializer "tenanfy.include_helpers" do |app|
      ActionController::Base.helper ::Tenanfy::Helpers
    end
  end
end
