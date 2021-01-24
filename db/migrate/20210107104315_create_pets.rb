class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :name
      t.date :birthday
      t.integer :gender
      t.string :introduction
      t.boolean :is_active, default: true
      t.integer :prefecture_id
      t.integer :age
      t.string :image
      
      t.timestamps
    end
  end
end
