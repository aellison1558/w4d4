class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @track = @note.track
    @note.save
    redirect_to track_url(@track)
  end

  def destroy
    @note = Note.find(params[:id])
    if @note && @note.user_id == current_user.id
      @track = @note.track
      @note.destroy
      redirect_to track_url(@track)
    else
      render text: "403 FORBIDDEN"
    end

  end

  private
  def note_params
    params[:note].permit(:note, :track_id)
  end

end
