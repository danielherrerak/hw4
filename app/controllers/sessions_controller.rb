class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome"
        redirect_to "/places"
      else
        flash["notice"] = "The information entered does not match our records"
        redirect_to "/login"
      end
    else
      flash["notice"] = "Please try again"
      redirect_to "/login"
    end
  end

  def destroy
    session["session_id"] = nil
    flash["notice"] = "Goodbye"
    redirect_to "/login"
  end
end
  