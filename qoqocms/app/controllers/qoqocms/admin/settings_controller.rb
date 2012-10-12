# -*- encoding: utf-8 -*-
module Qoqocms
  class Admin::SettingsController < Qoqocms::Admin::ApplicationController
    def index
      @settings = Setting.all
    end

    def show
      @setting = Setting.find(params[:id])
    end

    def new
      @setting = Setting.new
    end

    def edit
      @setting = Setting.find(params[:id])
    end

    def create
      @setting = Setting.new(params[:setting])
      if @setting.save
        redirect_to admin_settings_url, :notice => 'Параметр сохранен.'
      else
        render :action => "new"
      end
    end

    def update
      @setting = Setting.find(params[:id])

      if @setting.update_attributes(params[:setting])
        redirect_to admin_settings_url, :notice => 'Параметр сохранен.'
      else
        render :action => "edit"
      end
    end
  end
end