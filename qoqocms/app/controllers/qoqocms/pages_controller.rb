module Qoqocms
	class PagesController < ApplicationController
	  def index
	    url = ::Qoqocms::Page.normalize_url(params[:url] || '')
	    @page = ::Qoqocms::Page.find_by_url(url)
	    render :action => 'page404'  if @page.nil?
	  end
	end
end