# frozen_string_literal: true

require 'rails_helper'

describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

 let(:user) { FactoryBot.build(:user) }

    context 'last_nameカラム' do
      it '空欄でないこと' do
        user.last_name = ''
        is_expected.to eq false
      end
    end

    context 'first_nameカラム' do
      it '空欄でないこと' do
        user.first_name = ''
        is_expected.to eq false
      end
    end
    
    context 'last_name_kanaカラム' do
      it '空欄でないこと' do
        user.last_name_kana = ''
        is_expected.to eq false
      end
    end
    
    context 'first_name_kanaカラム' do
      it '空欄でないこと' do
        user.first_name_kana = ''
        is_expected.to eq false
      end
    end
    
    context 'zipcodeカラム' do
      it '空欄でないこと' do
        user.zipcode = ''
        is_expected.to eq false
      end
    end
    
    context 'addressカラム' do
      it '空欄でないこと' do
        user.address = ''
        is_expected.to eq false
      end
    end
    
    context 'phone_number' do
      it '空欄でないこと' do
        user.phone_number = ''
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること: 51文字は×' do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Petモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:pets).macro).to eq :has_many
      end
    end
  end
end
