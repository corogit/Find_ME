# frozen_string_literal: true

require 'rails_helper'

describe 'ペット管理機能', type: :system do
  describe '一覧表示' do
    let(:user_a) { FactoryBot.create(:user, first_name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, first_name: 'ユーザーB', email: 'b@example.com') }
    
    before do
      FactoryBot.create(:pet, name: '最初の投稿', user: user_a)
      visit user_session_path
      fill_in 'user_email', with: login_user.email
      fill_in 'user_password', with: login_user.password
      click_button 'Log in'
    end
    
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      
      it 'ユーザーAが作成したペットの投稿が表示される' do
        expect(page).to have_content '最初の投稿'
      end
    end
    
    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }
      
      it 'ユーザーAが作成したペットの投稿が表示されない' do
        expect(page).to have_no_content '最初の投稿'
      end
    end    
  end
end



