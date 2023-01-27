class ApplicationController < ActionController::Base

    # LLL

    before_action :require_logged_in, only: [:logout!]

    helper_method :current_user, :logged_in?

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        session[:session_token] = nil
        current_user.reset_session_token!
        @current_user = nil
    end

    def logged_in?
        !!current_user
    end
end