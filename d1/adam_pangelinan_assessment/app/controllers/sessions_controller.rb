class SessionsController < ApplicationController

    before_action :require_logged_in, only: [:destroy]

    def new # sign in
        render :new
    end
    
    def create # signing in
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user
            login!(@user)
            redirect_to users_url
        else
            flash.now[:errors] = ["Invalid email or password"]
            render :new
        end
    end

    def destroy # sign out
        logout!
        redirect_to new_session_url
    end
end
