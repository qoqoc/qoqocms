class Admin::UserRequestsController < Admin::ApplicationController
  def index
    @user_requests = UserRequest.ordered.paginate(:page => params[:page])
  end

  def show
    @user_request = UserRequest.find(params[:id])
  end

  def destroy
    @user_request = UserRequest.find(params[:id])
    @user_request.destroy
    
    redirect_to admin_user_requests_url
  end
end
