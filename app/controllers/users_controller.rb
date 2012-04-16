class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.send_activation
      redirect_to root_url, notice: t('flash.notice.user_activation_email_sent')
    else
      render 'new'
    end
  end

end
