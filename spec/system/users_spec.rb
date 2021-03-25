# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザのテスト' do
  let!(:user) { FactoryBot.build(:user) }

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it "「新規会員登録」と表示される" do
        expect(page).to have_content "新規会員登録"
      end
      it 'last_nameフォームが表示される' do
        expect(page).to have_field 'user[last_name]'
      end
      it 'first_nameフォームが表示される' do
        expect(page).to have_field 'user[first_name]'
      end
      it 'last_name_kanaフォームが表示される' do
        expect(page).to have_field 'user[last_name_kana]'
      end
      it 'first_name_kanaフォームが表示される' do
        expect(page).to have_field 'user[first_name_kana]'
      end
      it 'zipcodeフォームが表示される' do
        expect(page).to have_field 'user[zipcode]'
      end
      it 'addressフォームが表示される' do
        expect(page).to have_field 'user[address]'
      end
      it 'phone_numberフォームが表示される' do
        expect(page).to have_field 'user[phone_number]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '登録するボタンが表示される' do
        expect(page).to have_button "登録する"
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[last_name_kana]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[first_name_kana]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[zipcode]', with: Faker::Lorem.characters(number: 7)
        fill_in 'user[address]', with: Faker::Lorem.characters(number: 20)
        fill_in 'user[phone_number]', with: Faker::Lorem.characters(number: 11)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect {
          click_button '登録する'
        }.to change(User.all, :count).by(1)
      end
    end

  end

  describe 'ユーザログイン' do

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Sign inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end


  describe 'ユーザログアウトのテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      logout_link = find_all('a')[6].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end

end
