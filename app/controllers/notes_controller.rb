class NotesController < ApplicationController
  
  before_action :logged_in_user,only:[:create,:destroy,:edit]
  before_action :correct_user, only: :destroy
  
  def create
    
    @note=current_user.notes.build(note_params)
    if @note.save
      redirect_to root_path
    else
      @feed_items = []
      render 'notes/new'
    end
  end
  
  def destroy
    @note.destroy
    redirect_to request.referrer || root_path
  end
  
  def new
    @note=current_user.notes.build if logged_in?
  end
  
  def edit
    @note=Note.find(params[:id])
  end
  
  def update
     @note=Note.find(params[:id])
    if @note.update_attributes(note_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  
  private
  
  def note_params
    params.require(:note).permit(:content,:title,:picture)
  end
  
  def correct_user
     @note = current_user.notes.find_by(id: params[:id])
     redirect_to root_url if @note.nil?
  end
  
end
