class UserActivationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_activation if user
    redirect_to root_url, notice: t('flash.notice.user_activation_email_sent')
  end

  def edit
    @user = User.find_by_activation_token!(params[:id])
  end

  def update
    @user = User.find_by_activation_token!(params[:id])
    if @user.activation_sent_at < 1.hour.ago
      redirect_to new_activation_path, alert: t('flash.alert.activation_expired')
    elsif @user.update_attribute(:active, true)
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, notice: t('flash.notice.user_activated')
    else
      render :edit
    end
  end
end

