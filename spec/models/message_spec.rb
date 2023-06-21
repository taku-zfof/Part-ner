# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { build(:message) }
  describe "バリデーション" do
    it "有効な内容の場合仕事が保存される" do
      expect(message).to be_valid
    end
    it "内容が空だと保存されない" do
      message.content = ""
      expect(message).to_not be_valid
    end
  end


  describe "アソシエーション" do
    let(:association) { described_class.reflect_on_association(target) }
    context  do
      let(:target) { :user }
      it "userに対してbelongs_to" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context  do
      let(:target) { :chatroom }
      it "chatroomに対してbelongs_to" do
        expect(association.macro).to eq :belongs_to
      end
    end

  end
end