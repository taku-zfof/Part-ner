class CurrentUsersController < ApplicationController
  def show
    # @user=User.find(params[:id])
    @user=current_user
  end

  def edit
    @user=current_user
  end
  def update
    user=current_user
    if user.update(user_params)
     redirect_to current_user_path(current_user)
    else
     render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image, :sex, :age, :prefecture)
  end
end
