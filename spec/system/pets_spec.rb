# frozen_string_literal: true

require 'rails_helper'

describe '新規投稿のテスト' do

  let(:user) { FactoryBot.build(:user) }
  let(:pet) { FactoryBot.build(:pet) }

    def sign_in
      visit '/users/sign_in'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    context '投稿成功のテスト' do
      it '自分の新しい投稿が正しく保存される' do
        sign_in
        visit new_pet_path
        fill_in 'pet[name]', with: pet.name
        fill_in 'pet[birthday]', with: pet.birthday
        fill_in 'pet[image]', with: pet.image
        fill_in 'pet[gender]', with: pet.gender
        fill_in 'pet[prefecture]', with: pet.prefecture
        expect { click_on '投稿する' }.to change { Pet.count }.by(1)
        expect(current_path).to eq '/pets'
      end
    end
  

    context '編集のテスト' do
      it '自分の投稿が正しく編集される' do
        sign_in
        pet_1 = FactoryBot.create(:pet)
        visit edit_pet_path(pet_1)
        fill_in 'pet[name]', with: pet.name
        fill_in 'pet[birthday]', with: pet.birthday
        click_on '更新する'
        expect(page).to have_content 'pet_edit'
      end
    end

    context '削除のテスト' do
      it '自分の投稿が正しく削除される' do
        sign_in
        pet_1 = FactoryBot.create(:pet, user: user)
        visit pet_path(pet_1)
        expect { find(".delete-btn").click }.to change { Pet.count }.by(-1)
      end
    end
  end
 

  # describe '自分の投稿編集画面のテスト' do
  #   before do
  #     pet_1 = FactoryBot.create(:pet)
  #     visit edit_pet_path(pet_1)
  #   end

  #   context '表示の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/pets/' + pet.id.to_s + '/edit'
  #     end
  #     it '「投稿内容編集」と表示される' do
  #       expect(page).to have_content '投稿内容編集'
  #     end
  #     it 'name編集フォームが表示される' do
  #       expect(page).to have_field 'pet[name]', with: pet.name
  #     end
  #     it 'birthday編集フォームが表示される' do
  #       expect(page).to have_field 'pet[birthday]', with: pet.birthday
  #     end
  #     it 'age編集フォームが表示される' do
  #       expect(page).to have_field 'pet[age]', with: pet.age
  #     end
  #     it 'gender編集フォームが表示される' do
  #       expect(page).to have_field 'pet[gender]', with: pet.gender
  #     end
  #     it 'prefecture編集フォームが表示される' do
  #       expect(page).to have_field 'pet[prefecture_id]', with: pet.prefecture_id
  #     end
  #     it 'introduction編集フォームが表示される' do
  #       expect(page).to have_field 'pet[introduction]', with: pet.introduction
  #     end
  #     it 'Update Bookボタンが表示される' do
  #       expect(page).to have_button '更新する'
  #     end
  #     it '投稿の削除リンクが表示される' do
  #       expect(page).to have_link '削除する', href: pet_path(pet)
  #     end
  #   end

  #   context '編集成功のテスト' do
  #     before do
  #       @pet_old_name = pet.name
  #       @book_old_birthday = pet.birthday
  #       @pet_old_age = pet.age
  #       @pet_old_gender = pet.gender
  #       @pet_old_prefecture = pet.prefecture
  #       @pet_old_ontrpduction = pet. introduction
      
  #       click_button '更新する'
  #     end

  #     it 'nameが正しく更新される' do
  #       expect(pet.reload.name).not_to eq @pet_old_name
  #     end
  #     it 'genreが正しく更新される' do
  #       expect(pet.reload.genre).not_to eq @pet_old_genre
  #     end
  #     it 'birthdayが正しく更新される' do
  #       expect(pet.reload.birthday).not_to eq @pet_old_birthday
  #     end
  #     it 'ageが正しく更新される' do
  #       expect(pet.reload.age).not_to eq @pet_old_age
  #     end
  #     it 'genderが正しく更新される' do
  #       expect(pet.reload.gender).not_to eq @pet_old_gender
  #     end
  #     it 'prefectureが正しく更新される' do
  #       expect(pet.reload.prefecture).not_to eq @pet_old_prefecture
  #     end
  #     it 'introductionが正しく更新される' do
  #       expect(pet.reload.introduction).not_to eq @pet_old_introduction
  #     end
  #     it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
  #       expect(current_path).to eq '/pets/' + pet.id.to_s
  #       expect(page).to have_content 'ペット詳細'
  #     end
  #   end
  # end
