class UserConfirmationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_confirmation if user
    redirect_to root_url, notice: t('flash.notice.user_confirmation_email_sent')
  end

  def edit
    @user = User.find_by_confirmation_token!(params[:id])
  end

  def update
    @user = User.find_by_confirmation_token!(params[:id])
    if @user.confirmation_sent_at < 1.hour.ago
      redirect_to new_confirmation_path, alert: t('flash.alert.confirmation_expired')
    elsif @user.update_attribute(:confirmed, true)
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, notice: t('flash.notice.user_confirmed')
    else
      render :edit
    end
  end
end

