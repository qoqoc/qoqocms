class Admin::ApplicationController < ApplicationController
  before_filter :authorize
end
