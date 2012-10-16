module Qoqocms
  class ApplicationController < ActionController::Base
  	include ::Clearance::Authentication
  	include ApplicationHelper

  	protect_from_forgery
  end
end
