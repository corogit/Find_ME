# frozen_string_literal: true

require 'rails_helper'

describe 'ペット管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, first_name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, first_name: 'ユーザーB', email: 'b@example.com') }
  let!(:pet_a) { FactoryBot.create(:pet, name: '最初の投稿', user: user_a) }
  
  before do
    visit user_session_path
    fill_in 'user_email', with: login_user.email
    fill_in 'user_password', with: login_user.password
    click_button 'Log in'
  end
  
  shared_examples_for 'ユーザーAが作成したペットの投稿が表示される' do
    it { expect(page).to have_content '最初の投稿' }
  end
    
  describe '一覧表示機能' do  
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      
      it_behaves_like 'ユーザーAが作成したペットの投稿が表示される' 
    end
    
    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }
      
      it 'ユーザーAが作成したペットの投稿が表示されない' do
        expect(page).to have_no_content '最初の投稿'
      end
    end    
  end
  
  
  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      
      before do
        visit pet_path(pet_a)
      end
      
      it_behaves_like 'ユーザーAが作成したペットの投稿が表示される' 
    end
  end
  
  describe '新規作成機能' do
    let(:login_user) { user_a }
    
    before do
      visit new_pet_path
      fill_in 'pet_age', with: pet_age
      click_button '投稿する'
    end
    
    context '新規作成画面で名前を入力した時' do
      let(:pet_age) { 2 }
      
      it '正常に登録される' do
        expect(page).to have_content 2
      end
    end
    
    context '新規作成画面で名前を入力しなかった時' do
      let(:pet_age) { '' }
      
      it 'エラーとなる' do
        within '.alert' do
          expect(page).to have_content '年齢を入力してください'
        end
      end
    end
  end
end



