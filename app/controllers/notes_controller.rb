class NotesController < ApplicationController
    before_action :set_note, only: [:show, :update, :destroy]
    before_action :authenticate_user!
  
    # GET /notes
    def index
      if current_user.admin?
        @notes = Note.all
        render json: @notes
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    # GET /notes/1
    def show
      render json: @note
    end
  
    # POST /notes
    def create
      @note = Note.new(note_params)
  
      if @note.save
        render json: @note, status: :created
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /notes/1
    def update
      if @note.update(note_params)
        render json: @note
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /notes/1
    def destroy
      @note.destroy
      head :no_content
    end
  
    private
  
    def set_note
      @note = Note.find(params[:id])
    end
  
    def note_params
      params.require(:note).permit(:title, :description, :user_id)
    end
  end
  