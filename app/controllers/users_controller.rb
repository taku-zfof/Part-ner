class UsersController < ApplicationController
   before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find_by(account_name: params[:account_name])
  end
  def edit
    @user=User.find_by(account_name: params[:account_name])
  end
  def update
    user = current_user
    if user.update(user_params)
      redirect_to user_path(current_user),flash: {notice: '編集を保存しました。'}
    else
      @user = current_user
      flash.now[:error] = '登録に失敗しました'
      render :edit 
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image, :sex, :age, :prefecture)
  end
  
  def ensure_guest_user
    @user = User.find_by(account_name: params[:account_name])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), flash: {error: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'}
    end
  end  
end
