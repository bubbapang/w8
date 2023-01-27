module NoteSystemHelper
  def make_note_for_user(user, title = 'Laundry', description = 'Do before 5pm!', secret = 'false')
    visit user_url(user)
    fill_in 'Title', with: title
    fill_in 'Description', with: description
    choose(option: secret)
    click_button 'Create Note'
  end

  def make_note_for_jack(title, description, secret)
    jack = User.find_by(email: 'jack_bruce@bruce.com')
    make_note_for_user(jack, title, description, secret)
  end

  def get_jack
    User.find_by(email: 'jack_bruce@bruce.com')
  end
end
