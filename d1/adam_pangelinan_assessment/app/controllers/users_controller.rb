class UsersController < ApplicationController

    before_action :require_logged_in, only: [:index, :show]

    def new # sign up
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        @user.save
        if @user.save # if there IS a user
            login!(@user) # log them in
            redirect_to users_url # redirect to their page
        else # if a user COULD NOT be found
            if @user.email == "" # check if the email was blank
                flash.now[:errors] = ["Email can't be blank"] # error appropriately
                render :new
            end
            if @user.password.length < 6 # check if the password was short
                flash.now[:errors] = ["Password is too short (minimum is 6 characters)"] # error appropriately
                render :new
            end
        end
    end

    # DISPLAY
    def index
        @users = User.all
        render :index
    end
    
    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

end
