# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:job) { build(:job) }

  context "公開する場合のテスト" do

    it "有効な内容の場合仕事が保存される" do
      expect(job).to be_valid(:release)
    end
    it "タイトルが0文字だと保存されない" do
      job.tytle = ''
      expect(job).to_not be_valid(:release)
      expect(job.errors[:tytle]).to include("は1文字以上で入力してください")
    end
    it "タイトルが30文字以上だと保存されない" do
      job.tytle = Faker::Lorem.characters(number: 31)
      expect(job).to_not be_valid(:release)
      expect(job.errors[:tytle]).to include("は30文字以内で入力してください")
    end
    it "職種が空だと保存されない" do
      job.job_type = ""
      expect(job).to_not be_valid(:release)
      expect(job.errors[:job_type]).to include("を入力してください")
    end
    it "都道府県が空だと保存されない" do
      job.prefecture_code = ""
      expect(job).to_not be_valid(:release)
      expect(job.errors[:prefecture_code]).to include("を入力してください")
    end
    it "住所が空だと保存されない" do
      job.other_address = ""
      expect(job).to_not be_valid(:release)
      expect(job.errors[:other_address]).to include("を入力してください")
    end


    it "郵便番号が8桁だと保存されない" do
      job.postal_code = "00000000"
      expect(job).to_not be_valid(:release)
      expect(job.errors[:postal_code]).to include("は不正な値です")
    end
    it "郵便番号が6桁だと保存されない" do
      job.postal_code = "000000"
      expect(job).to_not be_valid(:release)
      expect(job.errors[:postal_code]).to include("は不正な値です")
    end
    it "郵便番号が全角だと保存されない" do
      job.postal_code = "１１１１１１１"
      expect(job).to_not be_valid(:release)
      expect(job.errors[:postal_code]).to include("は不正な値です")
    end
    it "郵便番号にハイフンがあっても保存できる" do
      job.postal_code = "000-0000"
      expect(job).to be_valid(:release)
    end
    it "郵便番号のハイフン位置が違うと保存されない" do
      job.postal_code = "00-00000"
      expect(job).to_not be_valid(:release)
      expect(job.errors[:postal_code]).to include("は不正な値です")

      job.postal_code = "0000-000"
      expect(job).to_not be_valid(:release)
      expect(job.errors[:postal_code]).to include("は不正な値です")
    end


    it "時給が全角だと保存されない" do
      job.hourly_wage = "１０００"
      expect(job).to_not be_valid(:release)
      expect(job.errors[:hourly_wage_before_type_cast]).to include("は不正な値です")
    end

    it "紹介が0文字だと保存されない" do
      job.introduction =  ""
      expect(job).to_not be_valid(:release)
      expect(job.errors[:introduction]).to include("は1文字以上で入力してください")
    end
    it "紹介が3000文字以上だと保存されない" do
      job.introduction =  Faker::Lorem.characters(number: 3001)
      expect(job).to_not be_valid(:release)
      expect(job.errors[:introduction]).to include("は3000文字以内で入力してください")
    end

  end

  context "下書きの場合のテスト" do
    
    it "有効な内容の場合仕事が保存される" do
      expect(job).to be_valid(:release)
    end
    it "タイトルが0文字でも保存できる" do
      job.tytle = ''
      expect(job).to be_valid
    end
    it "タイトルが30文字以上でも保存できる" do
      job.tytle = Faker::Lorem.characters(number: 31)
      expect(job).to be_valid
    end
    it "職種が空でも保存できる" do
      job.job_type = ""
      expect(job).to be_valid
    end
    it "都道府県が空でも保存できる" do
      job.prefecture_code = ""
      expect(job).to be_valid
    end
    it "住所が空でも保存できる" do
      job.other_address = ""
      expect(job).to be_valid
    end


    it "郵便番号が8桁でも保存できる" do
      job.postal_code = "00000000"
      expect(job).to be_valid
    end
    it "郵便番号が6桁でも保存できる" do
      job.postal_code = "000000"
      expect(job).to be_valid
    end
    it "郵便番号が全角でも保存できる" do
      job.postal_code = "１１１１１１１"
      expect(job).to be_valid
    end
    it "郵便番号にハイフンがあっても保存できる" do
      job.postal_code = "000-0000"
      expect(job).to be_valid
    end
    it "郵便番号のハイフン位置が違っても保存できる" do
      job.postal_code = "00-00000"
      expect(job).to be_valid

      job.postal_code = "0000-000"
      expect(job).to be_valid
    end


    it "時給が全角でも保存できる" do
      job.hourly_wage = "１０００"
      expect(job).to be_valid
    end

    it "紹介が0文字でも保存できる" do
      job.introduction =  ""
      expect(job).to be_valid
    end
    it "紹介が3000文字以上でも保存できる" do
      job.introduction =  Faker::Lorem.characters(number: 3001)
      expect(job).to be_valid
    end
  end
end