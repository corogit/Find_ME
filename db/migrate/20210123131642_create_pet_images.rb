class CreatePetImages < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_images do |t|
      t.integer :pet_id
      t.string :image_id

      t.timestamps
    end
  end
end
