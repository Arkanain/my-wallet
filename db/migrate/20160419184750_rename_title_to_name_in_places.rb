class RenameTitleToNameInPlaces < ActiveRecord::Migration
  def change
    rename_column :places, :title, :name
  end
end
