class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.active? && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_url, notice: t('flash.notice.logged_in')
    else
      flash.now.alert = t('flash.alert.login_invalid')
      render 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: t('flash.notice.logged_out')
  end
end
