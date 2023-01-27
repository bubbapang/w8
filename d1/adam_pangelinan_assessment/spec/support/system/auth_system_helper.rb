module AuthSystemHelper
  def register(email)
    visit '/users/new'
    fill_in 'Email', with: email
    fill_in 'Password', with: 'abcdef'
    click_button 'Sign Up'
  end

  def register_as_jack_bruce
    register('jack_bruce@bruce.com')
  end

  def sign_in(email)
    visit new_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'abcdef'
    click_button 'Sign In'
  end

  def sign_in_as_jack_bruce
    sign_in('jack_bruce@bruce.com')
  end
end
