class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def check_user
    if @user != current_user
      flash[:alert] = 'You have no sufficient rights to continue'
      redirect_to @question
    end
  end
end
