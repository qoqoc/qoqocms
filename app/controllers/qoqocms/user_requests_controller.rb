# -*- encoding: utf-8 -*-
module Qoqocms
  class UserRequestsController < ApplicationController
    def index

    end

    def create
      @page = Page.find_by_url('/contacts')

      @user_request = UserRequest.new(params[:user_request])

      if @user_request.save#_with_captcha
        redirect_to @page.full_url, notice: 'Ваша заявка отправлена.'
      else
        render "pages/index"
      end
    end
  end
end
