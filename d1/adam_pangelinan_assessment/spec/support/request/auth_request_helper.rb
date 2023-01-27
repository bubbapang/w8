module AuthRequestHelper
  def log_in_as(user)
    post session_url, params: { 
      user: {
        email: user.email,
        password: user.password
      }
    }
  end
end
