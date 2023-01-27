require 'rails_helper'

RSpec.describe "Notes", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Creating a note on user show page (hint: make sure your capitalization is exact!)' do
    context 'when logged in' do
      before do
        register_as_jack_bruce
        visit user_url(get_jack)
      end

      it 'has a form to "Add a New Note"' do
        expect(page).to have_content 'Add a New Note'
      end

      it 'takes a "Title" and "Description"' do
        expect(page).to have_content 'Title'
        expect(page).to have_content 'Description'
      end
      
      it 'has a radio button that allows a user to choose "true" if a note is secret' do
        # Find all the radio buttons - there should only be 2
        radio_buttons = all('input[type=radio]', maximum: 2)
        # Finds the one radio button with the value of true
        true_button_array = radio_buttons.select{|input| input.value == "true"}
        expect(true_button_array).not_to be_empty
      end

      it 'has a radio button that allows a user to choose "false" if a note is not secret' do
        # Find all the radio buttons - there should only be 2
        radio_buttons = all('input[type=radio]', maximum: 2)
        # Finds the one radio button with the value of false
        false_button_array = radio_buttons.select{|el| el.value == "false"}
        expect(false_button_array).not_to be_empty
      end

      context 'on a successful save' do
        before do
          fill_in 'Title', with: 'Found New Hike'
          fill_in 'Description', with: 'Found a great hiking path by the river - gotta do it again!'
          choose(option: 'false')
          click_button 'Create Note'
        end

        it 'redirects to the user show page' do
          expect(current_path).to eq(user_path(get_jack))
          expect(page).to have_content 'Found New Hike'
        end
      end

      context 'on a failed save' do
        before do
          fill_in 'Title', with: 'Found Cool Rock'
          choose(option: 'false')
          click_button 'Create Note'
        end

        it 'redirects to the user show page' do
          expect(current_path).to eq(user_path(get_jack))
        end

        it 'renders errors to the user' do
          expect(page).to have_content "Description can't be blank"
        end

        it 'still allows for a successful save' do
          fill_in 'Title', with: 'Found Cool Rock'
          fill_in 'Description', with: 'Off the path by the post office'
          choose(option: 'false')
          click_button 'Create Note'
          expect(page).to have_content 'Found Cool Rock'
        end
      end
    end
  end    

  describe 'Showing a user\'s notes (hint: make sure your capitalization is exact!)' do
    context 'showing note `title` and `description`' do
      before do
        register_as_jack_bruce
        make_note_for_jack('Remember to buy Milk', 'Making a cake tonight!', 'false')
        make_note_for_jack('Found the best cake recipe', 'Funfetti for life', 'false')
        visit user_url(get_jack)
      end

      it 'lists the titles of a user\'s notes on the user\'s show page' do
        expect(page).to have_content 'Remember to buy Milk'
        expect(page).to have_content 'Found the best cake recipe'
      end

      it 'lists the descriptions of a user\'s notes on the user\'s show page' do
        expect(page).to have_content 'Making a cake tonight!'
        expect(page).to have_content 'Funfetti for life'
      end
    end

    context 'showing a note only if NOT secret' do
      before do
        register_as_jack_bruce
        visit user_url(get_jack)
      end
      
      it 'will NOT show a secret note on the user\'s show page' do
        make_note_for_jack('Secret Message', 'ooooh don\'t tell!', 'true')
        expect(page).not_to have_content 'Secret Message'
      end

      it 'will show a non-secret note on the user\'s show page' do
        make_note_for_jack('Mundane Message', 'everyone can read this!', 'false')
        expect(page).to have_content 'Mundane Message'
      end
    end

    context 'allowing a note to be edited' do
      before do
        register_as_jack_bruce
        visit user_url(get_jack)
      end
      
      it "displays a link to edit a note" do
        make_note_for_jack('Cool Note', 'Woop!', 'false')
        expect(page).to have_content 'Edit Note'
      end
    end
  end

  describe 'Editing an existing note (hint: make sure your capitalization is exact!)' do
    context 'when logged in' do
      before do
        register_as_jack_bruce
        make_note_for_jack('To-Do', 'Get groceries', 'false')
        click_link 'Edit Note'
      end
      
      it 'has an "Edit Note" form to edit an existing note' do
        expect(page).to have_content 'Edit Note'
      end

      it 'takes a "Title" and "Description"' do
        expect(page).to have_content 'Title'
        expect(page).to have_content 'Description'
      end
    end

    context 'on a successful update' do
      before do
        register_as_jack_bruce
        make_note_for_jack('To-Do', 'Get groceries', 'false')
        click_link 'Edit Note'
        fill_in 'Title', with: 'ToDo'
        click_button 'Save Edited Note'
      end

      it 'redirects to the user\'s show page and updates the note\'s information' do
        expect(current_path).to eq(user_path(get_jack))
        expect(page).to have_content 'ToDo'
      end
    end

    context 'on a failed update' do
      before do
        register_as_jack_bruce
        make_note_for_jack('To-Do', 'Get groceries', 'false')
        click_link 'Edit Note'
        fill_in 'Title', with: ''
        fill_in 'Description', with: 'my new note description'
        click_button 'Save Edited Note'
      end

      it 'returns to the edit form displaying "Something went wrong!"' do
        expect(page).to have_content "Something went wrong!"
      end

      it 'prefills information from a failed update and still allows for a successful update' do
        expect(find_field('Description').value).to eq('my new note description')
        fill_in 'Title', with: 'New Note Title'
        click_button 'Save Edited Note'
        expect(page).to have_content 'New Note Title'
      end
    end
  end
end