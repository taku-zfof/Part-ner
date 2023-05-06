class CurrentUsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  def show
    # @user=User.find(params[:id])
    @user=current_user
  end

 
end
