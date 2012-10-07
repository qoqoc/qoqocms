class PagesController < ApplicationController
  def index
    url = Page.normalize_url(params[:url] || '')
    @page = Page.find_by_url(url)
    render :action => 'page404'  if @page.nil?
  end
end
