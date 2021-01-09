class RenameGanreIdColumnToPets < ActiveRecord::Migration[5.2]
  def change
    rename_column :pets, :ganre_id, :genre_id
  end
end
