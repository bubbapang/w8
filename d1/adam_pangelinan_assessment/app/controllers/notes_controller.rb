class NotesController < ApplicationController

    before_action :require_logged_in, only: [:create]

    def create # saving notes to the db
        @note = Note.new(notes_params)
        if @note.save
            redirect_to user_url(@note.author_id)
        else
            flash[:errors] = @note.errors.full_messages
            redirect_to users_url
        end
    end

    def edit # GETs the edit form
        @note = Note.new
        render :edit
    end

    def update # saves the changes from the form, which has pre-filled values
        @note = 
    end

    private

    def notes_params
        params.require(:note).permit(:title, :description, :secret)
    end
end
