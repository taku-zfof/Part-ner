class UsersController < ApplicationController
   before_action :ensure_guest_user, only: [:edit]

  def show
    @user=User.find(params[:id])
    # @user=current_user
  end
  def edit
    @user=User.find(params[:id])
  end
  def update
    user=current_user
    if user.update(user_params)
     redirect_to user_path(current_user)
    else
     render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image, :sex, :age, :prefecture)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
