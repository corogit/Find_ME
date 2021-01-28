# frozen_string_literal: true

require 'rails_helper'

describe '新規投稿のテスト' do

  let!(:user) { FactoryBot.create(:user) }
  let!(:genre){ FactoryBot.create(:genre)}
  #let!(:pet) { FactoryBot.build(:pet, user: user, prefecture_id: '13') }

    def sign_in
      visit '/users/sign_in'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    def current_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    describe '投稿テスト' do
      before do
        current_user
        visit new_pet_path
#        fill_in 'pet_pet_images_images', with: pet.image
        attach_file "pet_pet_images_images", Rails.root + "app/assets/images/no_image.jpg"
        fill_in 'pet[name]', with: "hoge"
        fill_in 'pet[birthday]', with: "2020-1-1"
#        fill_in 'pet[gender]', with: pet.gender
        choose 'pet_gender_男の子'
#        fill_in 'pet[prefecture]', with: pet.prefecture
        select '京都府',from: 'pet[prefecture_id]'
        select genre.name, from: 'pet[genre_id]'
        fill_in 'pet[age]', with: '99'
      end

      # context '投稿成功のテスト' do
      #   it '自分の新しい投稿が正しく保存される' do

      #       expect {
      #         click_on '投稿する'
      #       }.to change { Pet.count }.by(1)
      #       expect(current_path).to eq '/pets'

      #   end
      # end
    end

    describe '編集のテスト' do
      before do
        pet = Pet.last
        visit edit_pet_path(pet)

        fill_in 'pet[name]', with: pet.name
        fill_in 'pet[birthday]', with: pet.birthday
        fill_in 'pet[pet_images_images][]', with: pet.image
        fill_in 'pet[gender]', with: pet.gender
        fill_in 'pet[prefecture]', with: pet.prefecture
        click_on '更新する'
      end
      # context '編集のテスト' do
      #   it '自分の投稿が正しく編集される' do
      #     expect(page).to have_content 'pet_edit'
      #   end
      # end
    end

    describe '削除' do
      before do
        pet = Pet.last
        visit edit_pet_path(pet)
      end
      # context '削除のテスト' do
      #   it '自分の投稿が正しく削除される' do
      #     expect { find("削除する").click }.to change { Pet.count }.by(-1)
      #   end
      # end
    end
  end



