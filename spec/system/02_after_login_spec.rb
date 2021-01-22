# frozen_string_literal: true

require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:pet) { create(:pet, user: user) }
  let!(:other_pet) { create(:pet, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

       it 'TOPを押すと、トップ画面に遷移する' do
        top_link = find_all('a')[1].native.inner_text
        top_link = top_link.delete(' ')
        top_link.gsub!(/\n/, '')
        click_link top_link
        is_expected.to eq '/'
      end
       it 'マイページを押すと、自分のユーザ詳細画面に遷移する' do
        user_link = find_all('a')[2].native.inner_text
        user_link = user_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link user_link
        is_expected.to eq '/users/' + user.id.to_s
      end
        it '飼い主さん募集中の動物たちを押すと、ペット一覧画面に遷移する' do
        pets_link = find_all('a')[3].native.inner_text
        pets_link = pets_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link pets_link
        is_expected.to eq '/pets'
      end
        it '投稿フォームを押すと、ペット新規投稿フォームに遷移する' do
        pets_new_link = find_all('a')[4].native.inner_text
        pets_new_link = pets_new_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link pets_new_link
        is_expected.to eq '/pets/new'
      end
      it 'ABOUTを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[5].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
    end
  end

  describe 'ペット投稿一覧画面のテスト' do
    before do
      visit pets_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/pets'
      end
      it '自分の投稿と他人の投稿のペットの画像のリンク先がそれぞれ正しい' do
        expect(page).to have_link '', href: pet_path(pet)
        expect(page).to have_link '', href: pet_path(other_pet)
      end
      it '自分の投稿と他人の投稿のペットの性別が表示される' do
        expect(page).to have_content pet.gender
        expect(page).to have_content other_pet.gender
      end
      it '自分の投稿と他人の投稿のペットの誕生日が表示される' do
        expect(page).to have_content pet.birthday
        expect(page).to have_content other_pet.birthday
      end
      it '自分の投稿と他人の投稿のペットの年齢が表示される' do
        expect(page).to have_content pet.age
        expect(page).to have_content other_pet.age
      end
      it '自分の投稿と他人の投稿のペットの都道府県が表示される' do
        expect(page).to have_content pet.prefecture.name
        expect(page).to have_content other_pet.prefecture.name
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.full_name
        expect(page).to have_content user.introduction
        expect(page).to have_content user.followers.count
        expect(page).to have_content user.followings.count
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit pet_path(pet)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/pets/' + pet.id.to_s
      end
      it '「ペット詳細」と表示される' do
        expect(page).to have_content 'ペット詳細'
      end
      it '投稿ペットの名前が表示される' do
        expect(page).to have_content pet.name
      end
       it '投稿ペットの誕生日が表示される' do
        expect(page).to have_content pet.birthday
      end
       it '投稿ペットの年齢が表示される' do
        expect(page).to have_content pet.age
      end
       it '投稿ペットの性別が表示される' do
        expect(page).to have_content pet.gender
      end
       it '投稿ペットの都道府県が表示される' do
        expect(page).to have_content pet.prefecture.name
      end
       it '投稿ペットの紹介が表示される' do
        expect(page).to have_content pet.introduction
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_pet_path(pet)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq '/pets/' + pet.id.to_s + '/edit'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_pet_path(pet)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/pets/' + pet.id.to_s + '/edit'
      end
      it '「投稿内容編集」と表示される' do
        expect(page).to have_content '投稿内容編集'
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'pet[name]', with: pet.name
      end
      it 'birthday編集フォームが表示される' do
        expect(page).to have_field 'pet[birthday]', with: pet.birthday
      end
        it 'age編集フォームが表示される' do
        expect(page).to have_field 'pet[age]', with: pet.age
      end
        it 'gender編集フォームが表示される' do
        expect(page).to have_field 'pet[gender]', with: pet.gender
      end
        it 'prefecture編集フォームが表示される' do
        expect(page).to have_field 'pet[prefecture_id]', with: pet.prefecture_id
      end
        it 'introduction編集フォームが表示される' do
        expect(page).to have_field 'pet[introduction]', with: pet.introduction
      end
      it 'Update Bookボタンが表示される' do
        expect(page).to have_button '更新する'
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除する', href: pet_path(pet)
      end
    end

    context '編集成功のテスト' do
      before do
        @pet_old_name = pet.name
        @book_old_birthday = pet.birthday
        @pet_old_age = pet.age
        @pet_old_gender = pet.gender
        @pet_old_prefecture = pet.prefecture
        @pet_old_ontrpduction = pet. introduction
        fill_in 'pet[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'pet[age]', with: Faker::Lorem.sentence
        click_button '更新する'
      end

      it 'nameが正しく更新される' do
        expect(pet.reload.name).not_to eq @pet_old_name
      end
      it 'genreが正しく更新される' do
        expect(pet.reload.genre).not_to eq @pet_old_genre
      end
      it 'birthdayが正しく更新される' do
        expect(pet.reload.birthday).not_to eq @pet_old_birthday
      end
      it 'ageが正しく更新される' do
        expect(pet.reload.age).not_to eq @pet_old_age
      end
      it 'genderが正しく更新される' do
        expect(pet.reload.gender).not_to eq @pet_old_gender
      end
      it 'prefectureが正しく更新される' do
        expect(pet.reload.prefecture).not_to eq @pet_old_prefecture
      end
      it 'introductionが正しく更新される' do
        expect(pet.reload.introduction).not_to eq @pet_old_introduction
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/pets/' + pet.id.to_s
        expect(page).to have_content 'ペット詳細'
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧のユーザ画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
      end
      it '投稿一覧に自分の投稿のnameが表示され、リンクが正しい' do
        expect(page).to have_link pet.name, href: pet_path(pet)
      end
      it '投稿一覧に自分の投稿のbirthdayが表示される' do
        expect(page).to have_content pet.birthday
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
        expect(page).not_to have_content other_pet.name
        expect(page).not_to have_content other_pet.birthday
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.full_name
        expect(page).to have_content user.introduction
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_user_path(user)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[last_name]', with: user.last_name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '自己紹介編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it 'Update Userボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_full_name = user.full_name
        @user_old_intrpduction = user.introduction
        fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '変更を保存'
      end

      it 'last_nameが正しく更新される' do
        expect(user.reload.full_name).not_to eq @user_old_lastl_name
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_intrpduction
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end