require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let(:jack) { User.create!(email: 'jack_bruce@bruce.com', password: 'abcdef') }
  let(:jasmine) { User.create!(email: 'jasmine@jazzyjaz.com', password: 'abcdef') }
  let(:jasmine_note) { Note.create!(title: 'History Homework', description: 'make sure it\'s done by Friday', secret: 'false', author: jasmine) }

  describe 'POST /users/:user_id/notes (#create)' do
    # NOTE: for post requests, the user_id WILL be sent in the url, like so:
    # 'users/1/notes'

    context 'when logged in' do
      before do
        log_in_as(jack)
      end

      context 'with invalid params' do
        it 'appropriately stores error messages for display and redirects to the user\'s show page' do
          post user_notes_url(jasmine), params: { note: { title: 'this is an invalid note', secret: 'false' } }
          expect(response).to redirect_to(user_url(jasmine))
          expect(flash[:errors]).to eq(["Description can't be blank"])
        end
      end

      context 'with valid params' do
        it 'creates the note and redirects to the user\'s show page' do
          post user_notes_url(jasmine), params: { user_id: jasmine.id, note: { title: 'Note to self', description: 'you got this', secret: 'true' } }
          expect(response).to redirect_to(user_url(jasmine))
          expect(Note.exists?(title: 'Note to self')).to be true
        end
      end
    end

    context 'when logged out' do
      it 'redirects to the login page' do
        post user_notes_url(jasmine), params: { user_id: jasmine.id, note: { title: 'Another note to self', description: 'Climb that mountain of success!', secret: 'true' } }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "GET /notes/:id/edit (#edit)" do
    context "when logged in" do
      before do
        log_in_as(jasmine)
      end

      it "renders the \"Edit Note\" page (even if logged-in user is not the author)" do
        get edit_note_url(jasmine_note), params: {id: jasmine_note.id}
        expect(response.body).to include("Edit Note")
        expect(response.body).not_to include("All Users")
        expect(response.body).not_to include("Sign Up")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("Notes for")
      end
    end

    context "when logged out" do
      it "redirects to the login page" do
        get edit_note_url(jasmine_note), params: {id: jasmine_note.id}
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'PATCH /notes/:id (#update)' do
    context 'when logged in as a different user' do
      before do
        log_in_as(jack)
      end

      it 'does not allow users to update another user\'s notes' do
        patch note_url(jasmine_note), params: { id: jasmine_note.id, note: { title: 'Jack\'s Note now!' }}
        edited_note = Note.find(jasmine_note.id)
        expect(edited_note.title).not_to eq('Jack\'s Note now!')
      end

      it 'returns to the "Edit Note" form and appropriately stores error message "Something went wrong!" for display' do
        patch note_url(jasmine_note), params: { id: jasmine_note.id, note: { title: 'Jack\'s Note now!' }}
        expect(response.body).to include('Edit Note')
        expect(flash.now[:errors]).to eq(['Something went wrong!'])
      end
    end

    context 'when logged in as the note\'s owner' do
      before do
        log_in_as(jasmine)
      end

      it 'updates the note and redirects to the current user\'s show page' do
        patch note_url(jasmine_note), params: { id: jasmine_note.id, note: { title: 'Updated Note Title!' }}
        expect(Note.exists?(title: 'Updated Note Title!')).to be true
        expect(response).to redirect_to(user_url(jasmine)) 
      end
    end

    context 'when logged out' do
      it 'redirects to the login page' do
        patch note_url(jasmine_note), params: { id: jasmine_note.id, note: { title: 'Updated Note Title!' }}
        expect(response).to redirect_to(new_session_url)
      end
    end
  end
end