class ApplicationController < ActionController::Base

  include Tenanfy::Controller
  protect_from_forgery
end
