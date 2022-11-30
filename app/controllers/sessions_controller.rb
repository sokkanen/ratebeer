class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user&.authenticate(params[:password])
      if user.closed
        redirect_to signin_path, notice: 'Your account has been suspended. Please contact site administrator'
      else
        session[:user_id] = user.id
        redirect_to user, notice: "Welcome back!"
      end
    else
      redirect_to signin_path, notice: 'Username and/or password mismatch'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
