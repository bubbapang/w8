require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject (:jasmine) { User.create!(email: 'jasmine@jasmine.com', password: 'abcdef') }
  let (:jack) { User.create!(email: 'jackyboy@jack.com', password: 'abcdef') }

  describe 'GET /users/new (#new)' do
    it 'renders the "Sign Up" form' do
      get new_user_url
      expect(response.body).to include("Sign Up")
      expect(response.body).not_to include("Sign In")
      expect(response.body).not_to include("All Users")
      expect(response.body).not_to include("Notes for")
    end
  end

  describe 'POST /users (#create)' do
    context 'with blank email' do
      it 'returns to the "Sign Up" page and appropriately stores "Email can\'t be blank" error message for display"' do
        post users_url, params: { user: { email: '', password: 'abcdef' } }
        expect(response.body).to include("Sign Up")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("All Users")
        expect(response.body).not_to include("Notes for")
        expect(flash.now[:errors]).to eq(["Email can't be blank"])
      end
    end

    context 'with too-short password' do
      it 'returns to the "Sign Up" page and appropriately stores "Password is too short (minimum is 6 characters)" for display"' do
        post users_url, params: { user: { email: 'jack_bruce', password: 'short' } }
        expect(response.body).to include("Sign Up")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("All Users")
        expect(response.body).not_to include("Notes for")
        expect(flash.now[:errors]).to eq(["Password is too short (minimum is 6 characters)"])
      end
    end

    context 'with valid params' do
      it 'redirects user to the user index' do
        post users_url, params: { user: { email: 'jack_bruce', password: 'password' } }
        expect(response).to redirect_to(users_url)
      end

      it 'logs in the user' do
        post users_url, params: { user: { email: 'jack_bruce', password: 'abcdef' } }
        user = User.find_by_email('jack_bruce')
        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end

  describe 'GET /users/:id (#show)' do
    context 'when logged in' do
      before do
        log_in_as(jasmine)
      end

      it 'renders the specified user\'s show page displaying "Notes for <user\'s email>"' do
        get user_url(jasmine), params: {id: jasmine.id}
        fetched_user = controller.instance_variable_get(:@user)
        expect(fetched_user).to eq(User.find(jasmine.id))
        expect(response.body).to include("Notes for jasmine@jasmine.com")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("All Users")
        expect(response.body).not_to include("Sign Up")
      end
    end

    context 'when logged out' do
      it 'redirects to the login page' do
        get user_url(jasmine), params: {id: jasmine.id}
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'GET /users (#index)' do
    context 'when logged in' do
      before do
        log_in_as(jasmine)
      end

      it 'renders the index page displaying "All Users"' do
        get users_url
        expect(response.body).to include("All Users")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("Sign Up")
        expect(response.body).not_to include("Notes for")
      end
    end

    context 'when logged out' do
      it 'redirects to the login page' do
        get users_url
        expect(response).to redirect_to(new_session_url)
      end
    end
  end
end
