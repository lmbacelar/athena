class UsersController < ApplicationController
  respond_to :html, :json

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to root_url, notice: "#{User.model_name.human} #{ t('flash.notice.update')}"
    else
      render action: 'edit'
    end
  end

end
