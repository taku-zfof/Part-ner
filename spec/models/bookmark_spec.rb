# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { build(:bookmark) }
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
    
  end
end