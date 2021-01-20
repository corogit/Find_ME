class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :name
      t.date :birthday
      t.integer :gender
      t.string :introduction
      t.string :image_id
      t.boolean :is_active
      t.integer :prefecture_id
      t.integer :age

      t.timestamps
    end
  end
end
