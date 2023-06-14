# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :ensure_guest_user, only: [:edit]
  before_action :ensure_user, only:[:edit, :update]

  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(current_user),flash: {notice: "編集を保存しました。"}
    else
      @user = current_user
      flash.now[:error] = "更新に失敗しました"
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :image, :sex, :age, :prefecture)
    end
    
    def set_user
      @user = User.find_by(account_name: params[:account_name])
    end

    def ensure_guest_user
      @user = User.find_by(account_name: params[:account_name])
      if @user.name == "バイト太郎"
        redirect_to user_path(current_user), flash: {error: "ゲストユーザーはプロフィール編集画面へ遷移できません。"}
      end
    end

    def ensure_user
      user = User.find_by(account_name: params[:account_name])
      unless user == current_user
       redirect_back fallback_location: user_path(current_user), flash: {error: "権限がありません。"}
      end
    end
end
