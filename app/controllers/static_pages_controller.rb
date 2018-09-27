class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user=User.find_by(email:"sironitto-501@outlook.jp")
      @note  = current_user.notes.build
      @feed_items = current_user.feed
    end
  end
  
  def help
   @user=User.find_by(email:"sironitto-501@outlook.jp")
  end
end
