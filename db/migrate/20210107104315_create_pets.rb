class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.integer :genre_id
      t.string :name
      t.string :birthday
      t.boolean :gender
      t.string :introduction
      t.string :image_id
      t.boolean :is_active

      t.timestamps
    end
  end
end