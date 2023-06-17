# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context "バリデーション" do
    let(:user) { build(:user) }
    it "有効な内容の場合ユーザーが保存されるか" do
      expect(user).to be_valid
    end
    it "名前が0文字だと保存されない" do
      user.name = ''
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("は1文字以上で入力してください")
    end
    it "名前が16文字以上だと保存されない" do
      user.name = Faker::Lorem.characters(number: 16)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("は15文字以内で入力してください")
    end
    it "性別が空だと保存されない" do
      user.sex = ""
      expect(user).to_not be_valid
      expect(user.errors[:sex]).to include("を入力してください")
    end
    it "年齢が空だと保存されない" do
      user.age = ""
      expect(user).to_not be_valid
      expect(user.errors[:age]).to include("を入力してください")
    end
    it "都道府県が空だと保存されない" do
      user.prefecture = ""
      expect(user).to_not be_valid
      expect(user.errors[:prefecture]).to include("を入力してください")
    end
    it "自己紹介が1500文字以上だと保存されない" do
      user.introduction =  Faker::Lorem.characters(number: 1501)
      expect(user).to_not be_valid
      expect(user.errors[:introduction]).to include("は1500文字以内で入力してください")
    end
  end

  describe "アソシエーション" do
    let(:association) { described_class.reflect_on_association(target) }

    context  do
      let(:target) { :jobs }
      it "Jobに対してhas_many" do
        expect(association.macro).to eq :has_many
      end
    end

    context  do
      let(:target) { :bookmarks }
      it "bookmarkに対してhas_many" do
        expect(association.macro).to eq :has_many
      end
    end

    context do
      let(:target) { :offers }
      it "offerに対してhas_many" do
        expect(association.macro).to eq :has_many
      end
    end

    context do
      let(:target) { :messages }
      it  "messageに対してhas_many" do
        expect(association.macro).to eq :has_many
      end
    end
  end

end