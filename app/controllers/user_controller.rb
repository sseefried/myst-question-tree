class UserController < ApplicationController
  
  def login_form
    if session[:user_id]
      render :action => 'already_signed_in' 
    else
      render :action => 'login_form'
    end
  end

  def login
    render :action => 'already_signed_in' && return if session[:user_id]
    u = User.find_by_username('admin')
    if u && u.password_is?(params[:user][:password])
      session[:user_id] = u.id
      redirect_to :controller => 'admin'
    else
      flash[:errors] = "Incorrect password"
      render :action => 'login_form'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
  
end