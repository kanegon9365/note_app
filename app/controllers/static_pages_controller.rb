class StaticPagesController < ApplicationController
  def home
     @user=User.find_by(email:"sironitto-501@outlook.jp")
  end
  
  def help
   @user=User.find_by(email:"sironitto-501@outlook.jp")
  end
end
