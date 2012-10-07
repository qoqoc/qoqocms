class Admin::PagesController < Admin::ApplicationController

  before_filter :get_page, :only => [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new(params[:page])
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to admin_pages_url, notice: t('admin.pages_controller.created')
    else
      render action: "new"
    end
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to admin_pages_url, notice: t('admin.pages_controller.updated')
    else
      render action: "edit"
    end
  end

  def destroy
    @page.destroy

    redirect_to admin_pages_url, notice: t('admin.pages_controller.destroy')
  end

  protected

  def get_page
    @page = Page.find(params[:id])
  end
end
