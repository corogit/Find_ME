# frozen_string_literal: true

require 'rails_helper'

describe 'Petモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { pet.valid? }

    let(:user) { FactoryBot.build(:user) }
    let(:pet) { FactoryBot.build(:pet) }

    context 'nameカラム' do
      it '空欄でないこと' do
        pet.name = ''
        is_expected.to eq false
      end
    end
    
    context 'imageカラム' do
      it '空欄でないこと' do
        pet.image = ''
        is_expected.to eq false
      end
    end
    
    context 'birthdayカラム' do
      it '空欄でないこと' do
        pet.name = ''
        is_expected.to eq false
      end
    end
    
    context 'genderカラム' do
      it '空欄でないこと' do
        pet.name = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '空欄でないこと' do
        pet.introduction = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 201文字は×' do
        pet.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Pet.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
