class Tenanfy::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def run_migrations
    rake("tenanfy:install:migrations")
  end

  def copy_initializer
    template "initializer.rb", "config/initializers/apartment.rb"
  end

  def setup_middleware
    inject_into_class "config/application.rb", 'Application' do
      "\n   require 'tenanfy/apartment/elevator'\n" +
      "   config.middleware.use 'Apartment::Elevators::Generic', Tenanfy::Apartment::Elevator.new\n"
    end
  end

  def setup_application_controller
    inject_into_class "app/controllers/application_controller.rb", 'ApplicationController' do
      "\n  include Tenanfy::Controller\n"
    end
  end
end
