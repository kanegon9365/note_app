class LikesController < ApplicationController
  
  before_action :logged_in_user
  
  def create
    @note = Note.find(params[:note_id])
    unless @note.iine(current_user)
      @note.iine(current_user)
      @note.reload
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
    end
    end
  end

  def destroy
    @note = Like.find(params[:id]).note
    
    if @note.iine?(current_user)
      @note.uniine(current_user)
      @note.reload
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    end
  end
  
end
