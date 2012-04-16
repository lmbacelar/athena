class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #cookies[:auth_token] = @user.auth_token
      @user.send_confirmation
      redirect_to root_url, notice: t('flash.notice.user_confirmation_email_sent')
    else
      render 'new'
    end
  end

end
