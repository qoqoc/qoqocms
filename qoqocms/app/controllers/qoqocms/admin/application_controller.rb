module Qoqocms
	class Admin::ApplicationController < ApplicationController
	  before_filter :authorize
	end
end
