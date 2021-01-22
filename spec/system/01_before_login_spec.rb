# frozen_string_literal: true

require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
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

  describe 'アバウト画面のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'Find ME'
      end
      it 'TOPリンクが表示される: 左上から1番目のリンクが「TOP」である' do
        top_link = find_all('a')[1].native.inner_text
        expect(top_link).to eq("TOP")
      end
      it 'ABOUTリンクが表示される: 左上から2番目のリンクが「ABOUT」である' do
        about_link = find_all('a')[2].native.inner_text
        expect(about_link).to eq("ABOUT")
      end
      it '飼い主さん募集中の動物たちリンクが表示される: 左上から3番目のリンクが「飼い主さん募集中の動物たち」である' do
        pets_link = find_all('a')[3].native.inner_text
        expect(pets_link).to eq("飼い主さん募集中の動物たち")
      end
        it '登録するリンクが表示される: 左上から4番目のリンクが「登録する」である' do
        sign_up_link = find_all('a')[4].native.inner_text
        expect(sign_up_link).to eq("登録する")
      end
        it 'ログインリンクが表示される: 左上から5番目のリンクが「ログイン」である' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(log_in_link).to eq("ログイン")
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'TOPを押すと、トップ画面に遷移する' do
        top_link = find_all('a')[1].native.inner_text
        top_link = top_link.delete(' ')
        top_link.gsub!(/\n/, '')
        click_link top_link
        is_expected.to eq '/'
      end
      it 'ABOUTを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[2].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it '飼い主さん募集中の動物たちを押すと、ペット一覧画面に遷移する' do
        pets_link = find_all('a')[3].native.inner_text
        pets_link = pets_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link pets_link
        is_expected.to eq '/pets'
      end
      it '登録するを押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[4].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[5].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/users/sign_in'
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
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
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
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
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
        expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

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
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
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

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    context 'ヘッダーの表示を確認' do
      it 'TOPリンクが表示される: 左上から1番目のリンクが「TOP」である' do
        top_link = find_all('a')[1].native.inner_text
        expect(top_link).to eq("TOP")
      end
      it 'マイページリンクが表示される: 左上から2番目のリンクが「マイページ」である' do
        users_link = find_all('a')[2].native.inner_text
        expect(users_link).to eq("マイページ")
      end
      it '飼い主さん募集中の動物たちリンクが表示される: 左上から3番目のリンクが「飼い主さん募集中の動物たち」である' do
        pets_link = find_all('a')[3].native.inner_text
        expect(pets_link).to eq("飼い主さん募集中の動物たち")
      end
      it '投稿フォームリンクが表示される: 左上から4番目のリンクが「投稿フォーム」である' do
        pets_new_link = find_all('a')[4].native.inner_text
        expect(pets_new_link).to eq("投稿フォーム")
      end
      it 'ABOUTリンクが表示される: 左上から5番目のリンクが「ABOUT」である' do
        about_link = find_all('a')[5].native.inner_text
        expect(about_link).to eq("ABOUT")
      end
      it 'ログアウトリンクが表示される: 左上から6番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[6].native.inner_text
        expect(logout_link).to eq("ログアウト")
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

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
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてABOUT画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end