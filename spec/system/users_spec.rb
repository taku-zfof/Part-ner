# frozen_string_literal: true

require 'rails_helper'

describe "ユーザーのテスト" do
  let(:user) { build(:user) }
  describe "新規登録画面のテスト" do
    before { visit new_user_registration_path }
    context '表示の確認' do
      it '新規登録画面か' do
        expect(page).to have_content 'Sign up'
      end
      it "新規登録フォームが表示されているか" do
        expect(page).to have_form
      end
    end
  end
  
end