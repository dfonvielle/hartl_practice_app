class CoolUsersController < ApplicationController
 
  def show
    @user = CoolUser.find(params[:id])
  end
 
 
  def new
  end
end
