# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end

  def is_admin
    redirect_to signin_path, notice: 'you should be an admin to perform this operation' if current_user.admin.nil? || current_user.admin == false
  end

end
