class AccessController < ApplicationController
  def index
    # display text
  end

  def login
    # display login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(:username => params[:username]).first
      if founder_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    flash[:notice] = "Logged Out"
    redirect_to(:action => "login")
  end

end
