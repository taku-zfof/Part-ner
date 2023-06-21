# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  let(:chatroom) { build(:bookmark) }
  describe "アソシエーション" do
    let(:association) { described_class.reflect_on_association(target) }
    context  do
      let(:target) { :user }
      it "userに対してbelongs_to" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context  do
      let(:target) { :job }
      it "jobに対してbelongs_to" do
        expect(association.macro).to eq :belongs_to
      end
    end
    
     context  do
      let(:target) { :messages }
      it "messagesに対してhas_many" do
        expect(association.macro).to eq :has_many
      end
    end

  end
end