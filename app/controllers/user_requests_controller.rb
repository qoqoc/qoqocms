# -*- encoding: utf-8 -*-
class UserRequestsController < ApplicationController
  def index

  end

  def new
    @user_request = UserRequest.new
  end

  def create
    @user_request = UserRequest.new(params[:user_request])

    if @user_request.save_with_captcha
      redirect_to user_requests_path, notice: 'Ваша заявка отправлена.'
    else
      render action: "new"
    end
  end
end
