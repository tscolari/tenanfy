class ApplicationController < ActionController::Base

  include Tenantfy::Controller
  protect_from_forgery
end
